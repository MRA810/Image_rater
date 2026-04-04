from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
from functools import wraps
import mysql.connector
from mysql.connector import Error
import bcrypt
import os
import random
from datetime import datetime, timedelta
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.secret_key = 'image_rater_secret_key_2024'

UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'webp'}
MAX_RATINGS = 10
COOLDOWN_HOURS = 10

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max

# ─── DB CONNECTION ────────────────────────────────────────────────────────────

def get_db():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='image_rater',
        charset='utf8mb4'
    )

def query(sql, params=None, fetchone=False, fetchall=False, commit=False):
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.execute(sql, params or ())
    result = None
    if fetchone:
        result = cur.fetchone()
    elif fetchall:
        result = cur.fetchall()
    if commit:
        conn.commit()
        result = cur.lastrowid
    cur.close()
    conn.close()
    return result

# ─── AUTH DECORATORS ──────────────────────────────────────────────────────────

def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'user_id' not in session:
            flash('Please log in to continue.', 'warning')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated

def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login'))
        if session.get('role') != 'admin':
            flash('Admin access required.', 'danger')
            return redirect(url_for('rate'))
        return f(*args, **kwargs)
    return decorated

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# ─── ROUTES: AUTH ─────────────────────────────────────────────────────────────

@app.route('/')
def index():
    if 'user_id' in session:
        if session.get('role') == 'admin':
            return redirect(url_for('admin_dashboard'))
        return redirect(url_for('rate'))
    return redirect(url_for('login'))

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if 'user_id' in session:
        return redirect(url_for('index'))
    if request.method == 'POST':
        username = request.form.get('username', '').strip()
        email = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        role = request.form.get('role', 'user')

        if not username or not email or not password:
            flash('All fields are required.', 'danger')
            return render_template('signup.html')

        if role not in ('admin', 'user'):
            role = 'user'

        existing = query("SELECT id FROM users WHERE email=%s OR username=%s", (email, username), fetchone=True)
        if existing:
            flash('Username or email already exists.', 'danger')
            return render_template('signup.html')

        pw_hash = bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
        user_id = query(
            "INSERT INTO users (username, email, password_hash, role) VALUES (%s,%s,%s,%s)",
            (username, email, pw_hash, role), commit=True
        )
        # Init rating session
        query(
            "INSERT INTO user_rating_session (user_id, ratings_count, last_rating_time) VALUES (%s, 0, NULL)",
            (user_id,), commit=True
        )
        flash('Account created! Please log in.', 'success')
        return redirect(url_for('login'))
    return render_template('signup.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'user_id' in session:
        return redirect(url_for('index'))
    if request.method == 'POST':
        email = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        user = query("SELECT * FROM users WHERE email=%s", (email,), fetchone=True)
        if user and bcrypt.checkpw(password.encode(), user['password_hash'].encode()):
            session['user_id'] = user['id']
            session['username'] = user['username']
            session['role'] = user['role']
            flash(f"Welcome back, {user['username']}!", 'success')
            if user['role'] == 'admin':
                return redirect(url_for('admin_dashboard'))
            return redirect(url_for('rate'))
        flash('Invalid credentials.', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out successfully.', 'info')
    return redirect(url_for('login'))

# ─── ROUTES: USER ─────────────────────────────────────────────────────────────

@app.route('/rate', methods=['GET', 'POST'])
@login_required
def rate():
    if session.get('role') == 'admin':
        return redirect(url_for('admin_dashboard'))

    user_id = session['user_id']
    now = datetime.now()

    # Get or create rating session
    sess = query("SELECT * FROM user_rating_session WHERE user_id=%s", (user_id,), fetchone=True)
    if not sess:
        query("INSERT INTO user_rating_session (user_id, ratings_count) VALUES (%s,0)", (user_id,), commit=True)
        sess = query("SELECT * FROM user_rating_session WHERE user_id=%s", (user_id,), fetchone=True)

    # Check cooldown
    if sess['cooldown_until'] and sess['cooldown_until'] > now:
        remaining = sess['cooldown_until'] - now
        hours = int(remaining.total_seconds() // 3600)
        minutes = int((remaining.total_seconds() % 3600) // 60)
        seconds = int(remaining.total_seconds() % 60)
        return render_template('cooldown.html',
                               hours=hours, minutes=minutes, seconds=seconds,
                               cooldown_until=sess['cooldown_until'].isoformat())

    # Handle POST rating
    if request.method == 'POST':
        image_id = request.form.get('image_id')
        rating_val = request.form.get('rating')

        try:
            rating_val = int(rating_val)
            if not (1 <= rating_val <= 10):
                raise ValueError
        except (ValueError, TypeError):
            flash('Rating must be between 1 and 10.', 'danger')
            return redirect(url_for('rate'))

        # Check duplicate
        dup = query("SELECT id FROM ratings WHERE user_id=%s AND image_id=%s", (user_id, image_id), fetchone=True)
        if dup:
            flash('You already rated this image.', 'warning')
            return redirect(url_for('rate'))

        # Insert rating
        query("INSERT INTO ratings (user_id, image_id, rating) VALUES (%s,%s,%s)",
              (user_id, image_id, rating_val), commit=True)

        new_count = sess['ratings_count'] + 1
        if new_count >= MAX_RATINGS:
            cooldown_until = now + timedelta(hours=COOLDOWN_HOURS)
            query("UPDATE user_rating_session SET ratings_count=%s, last_rating_time=%s, cooldown_until=%s WHERE user_id=%s",
                  (new_count, now, cooldown_until, user_id), commit=True)
            flash(f'You have rated {MAX_RATINGS} images! Cooldown of {COOLDOWN_HOURS} hours started.', 'info')
            return redirect(url_for('rate'))
        else:
            query("UPDATE user_rating_session SET ratings_count=%s, last_rating_time=%s WHERE user_id=%s",
                  (new_count, now, user_id), commit=True)
            flash('Rating submitted!', 'success')
            return redirect(url_for('rate'))

    # GET: find unrated image
    rated_ids = query("SELECT image_id FROM ratings WHERE user_id=%s", (user_id,), fetchall=True)
    rated_list = [r['image_id'] for r in rated_ids] if rated_ids else []

    if rated_list:
        placeholders = ','.join(['%s'] * len(rated_list))
        images = query(f"SELECT * FROM images WHERE id NOT IN ({placeholders})", rated_list, fetchall=True)
    else:
        images = query("SELECT * FROM images", fetchall=True)

    image = random.choice(images) if images else None
    ratings_left = MAX_RATINGS - sess['ratings_count']

    return render_template('rate.html', image=image, ratings_left=ratings_left, total=MAX_RATINGS)

@app.route('/my-history')
@login_required
def my_history():
    user_id = session['user_id']
    history = query("""
        SELECT r.rating, r.rated_at, i.image_name, i.image_path
        FROM ratings r
        JOIN images i ON r.image_id = i.id
        WHERE r.user_id = %s
        ORDER BY r.rated_at DESC
    """, (user_id,), fetchall=True)
    return render_template('my_history.html', history=history)

# ─── ROUTES: ADMIN ────────────────────────────────────────────────────────────

@app.route('/admin')
@admin_required
def admin_dashboard():
    analytics = query("""
        SELECT i.id, i.image_name, i.image_path, i.created_at,
               COUNT(r.id) AS total_ratings,
               ROUND(AVG(r.rating), 2) AS avg_rating
        FROM images i
        LEFT JOIN ratings r ON i.id = r.image_id
        GROUP BY i.id, i.image_name, i.image_path, i.created_at
        ORDER BY total_ratings DESC
    """, fetchall=True)

    top5 = [a for a in analytics if a['total_ratings'] > 0]
    top5 = sorted(top5, key=lambda x: x['avg_rating'] or 0, reverse=True)[:5]
    least5 = sorted([a for a in analytics if a['total_ratings'] > 0],
                    key=lambda x: x['avg_rating'] or 0)[:5]

    total_users = query("SELECT COUNT(*) AS c FROM users WHERE role='user'", fetchone=True)['c']
    total_images = query("SELECT COUNT(*) AS c FROM images", fetchone=True)['c']
    total_ratings = query("SELECT COUNT(*) AS c FROM ratings", fetchone=True)['c']

    return render_template('admin_dashboard.html',
                           analytics=analytics,
                           top5=top5,
                           least5=least5,
                           total_users=total_users,
                           total_images=total_images,
                           total_ratings=total_ratings)

@app.route('/admin/upload', methods=['GET', 'POST'])
@admin_required
def admin_upload():
    if request.method == 'POST':
        image_name = request.form.get('image_name', '').strip()
        file = request.files.get('image_file')

        if not image_name or not file:
            flash('Image name and file are required.', 'danger')
            return render_template('admin_upload.html')

        if not allowed_file(file.filename):
            flash('Only PNG, JPG, JPEG, GIF, WEBP allowed.', 'danger')
            return render_template('admin_upload.html')

        filename = secure_filename(file.filename)
        ext = filename.rsplit('.', 1)[1].lower()
        unique_name = f"{datetime.now().strftime('%Y%m%d%H%M%S')}_{filename}"
        save_path = os.path.join(app.config['UPLOAD_FOLDER'], unique_name)
        file.save(save_path)

        query("INSERT INTO images (image_name, image_path, uploaded_by) VALUES (%s,%s,%s)",
              (image_name, unique_name, session['user_id']), commit=True)
        flash(f'Image "{image_name}" uploaded successfully!', 'success')
        return redirect(url_for('admin_dashboard'))

    return render_template('admin_upload.html')

@app.route('/admin/history')
@admin_required
def admin_history():
    page = request.args.get('page', 1, type=int)
    per_page = 20
    offset = (page - 1) * per_page

    total = query("SELECT COUNT(*) AS c FROM ratings", fetchone=True)['c']
    history = query("""
        SELECT u.username, i.image_name, r.rating, r.rated_at
        FROM ratings r
        JOIN users u ON r.user_id = u.id
        JOIN images i ON r.image_id = i.id
        ORDER BY r.rated_at DESC
        LIMIT %s OFFSET %s
    """, (per_page, offset), fetchall=True)

    total_pages = (total + per_page - 1) // per_page
    return render_template('admin_history.html', history=history, page=page,
                           total_pages=total_pages, total=total)

@app.route('/admin/delete-image/<int:image_id>', methods=['POST'])
@admin_required
def delete_image(image_id):
    img = query("SELECT * FROM images WHERE id=%s", (image_id,), fetchone=True)
    if img:
        try:
            os.remove(os.path.join(app.config['UPLOAD_FOLDER'], img['image_path']))
        except:
            pass
        query("DELETE FROM ratings WHERE image_id=%s", (image_id,), commit=True)
        query("DELETE FROM images WHERE id=%s", (image_id,), commit=True)
        flash('Image deleted.', 'success')
    return redirect(url_for('admin_dashboard'))

if __name__ == '__main__':
    os.makedirs(UPLOAD_FOLDER, exist_ok=True)
    app.run(debug=True, port=5000)
