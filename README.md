# ImageRater — Role-Based Image Rating System

A full-stack Flask + MySQL web application with role-based authentication, rating limits, cooldown logic, and admin analytics.

---

## Tech Stack

| Layer     | Technology |
|-----------|-----------|
| Backend   | Python 3.10+, Flask 3.x |
| Database  | MySQL (via XAMPP) |
| Frontend  | HTML5, Bootstrap 5.3, FontAwesome 6 |
| Auth      | bcrypt password hashing, Flask sessions |
| Fonts     | DM Serif Display + DM Sans (Google Fonts) |

---

## Project Structure

```
image_rater/
├── app.py                  # Main Flask application
├── schema.sql              # MySQL database schema
├── requirements.txt        # Python dependencies
├── README.md
├── static/
│   ├── css/
│   │   └── main.css        # Brand stylesheet
│   └── uploads/            # Uploaded images (auto-created)
└── templates/
    ├── base.html           # Base layout with navbar
    ├── login.html          # Login page
    ├── signup.html         # Sign-up page
    ├── rate.html           # User image rating page
    ├── cooldown.html       # Cooldown timer page
    ├── my_history.html     # User's own rating history
    ├── admin_dashboard.html # Admin analytics dashboard
    ├── admin_upload.html   # Admin image upload form
    └── admin_history.html  # Admin full rating history
```

---

## Setup Instructions

### Step 1 — Start XAMPP

1. Open **XAMPP Control Panel**
2. Start **Apache** and **MySQL**
3. Open **phpMyAdmin** → `http://localhost/phpmyadmin`

### Step 2 — Create the Database

In phpMyAdmin:
1. Click **SQL** tab
2. Paste the entire contents of `schema.sql`
3. Click **Go**

This creates the `image_rater` database with all 4 tables and constraints.

### Step 3 — Install Python Dependencies

```bash
cd image_rater
pip install -r requirements.txt
```

##LIVE: npx localtunnel --port 5000 --subdomain imagerater

### Step 4 — Configure Database (if needed)

In `app.py`, find the `get_db()` function and adjust if your MySQL credentials differ:

```python
def get_db():
    return mysql.connector.connect(
        host='localhost',
        user='root',       # ← your MySQL user
        password='',       # ← your MySQL password (empty for XAMPP default)
        database='image_rater',
    )
```

### Step 5 — Run the App

```bash
python app.py
```

Open: **http://localhost:5000**

---

## Accounts & Roles

### Creating an Admin Account
To create an admin account, go to `/signup`, select **Admin** from the role dropdown, and enter the **Admin Invite Code** when prompted. Only valid invite codes allow admin registration.

### Creating a User Account
To create a regular user account, go to `/signup` and select **User** from the role dropdown. No invite code is required for standard users.
---
## Invite Code: UQID_SERIAL_ATLAS_4462381

## Database Schema

### `users`
| Column | Type | Notes |
|--------|------|-------|
| id | INT UNSIGNED PK | Auto-increment |
| username | VARCHAR(50) | Unique |
| email | VARCHAR(120) | Unique |
| password_hash | VARCHAR(255) | bcrypt |
| role | ENUM | 'admin' or 'user' |
| created_at | DATETIME | Default now |

### `images`
| Column | Type | Notes |
|--------|------|-------|
| id | INT UNSIGNED PK | Auto-increment |
| image_name | VARCHAR(150) | Display name |
| image_path | VARCHAR(255) | Filename in /static/uploads/ |
| uploaded_by | INT FK → users.id | |
| created_at | DATETIME | |

### `ratings`
| Column | Type | Notes |
|--------|------|-------|
| id | INT UNSIGNED PK | |
| user_id | INT FK → users.id | |
| image_id | INT FK → images.id | |
| rating | TINYINT | 1–10, CHECK constraint |
| rated_at | DATETIME | |
| — | UNIQUE(user_id, image_id) | One rating per user per image |

### `user_rating_session`
| Column | Type | Notes |
|--------|------|-------|
| user_id | INT PK FK → users.id | |
| ratings_count | TINYINT | Resets after cooldown |
| last_rating_time | DATETIME | |
| cooldown_until | DATETIME | NULL = no cooldown |

---

## Business Rules

| Rule | Implementation |
|------|---------------|
| Max 10 ratings per session | `user_rating_session.ratings_count` |
| 10-hour cooldown after 10 ratings | `cooldown_until = NOW() + 10h` |
| No duplicate ratings | `UNIQUE(user_id, image_id)` in DB |
| Random unrated image shown | Python `random.choice()` with SQL exclusion |
| Rating must be 1–10 | Server-side validation + DB CHECK |
| Admins can't rate | Route guard redirects to admin dashboard |

---

## Brand Colors

| Role | Hex |
|------|-----|
| Primary brand | `#245953` |
| Hover/dark | `#1B4440` |
| Page background | `#E0E0E0` |
| Panel/card background | `#F5F5F5` |
| Danger/delete | `#B00020` |
| Cooldown alert bg | `#FFE5E5` |

---

## Feature Checklist

- [x] User sign-up & login with bcrypt hashed passwords
- [x] Role-based access (admin / user)
- [x] Session-based authentication with decorators
- [x] Random unrated image shown per request
- [x] Star rating UI (1–10) with label descriptions
- [x] Duplicate rating prevention (DB UNIQUE constraint)
- [x] 10-rating limit with 10-hour cooldown
- [x] Live countdown timer on cooldown page
- [x] Ratings remaining badge on rate page
- [x] Admin: image upload with preview & drag-drop
- [x] Admin: analytics dashboard (AVG, COUNT per image)
- [x] Admin: full rating history with pagination
- [x] Admin: delete image (cascades ratings)
- [x] Top 5 highest rated images
- [x] Least 5 rated images
- [x] User's personal rating history page
- [x] Secure file upload (Werkzeug, extension filter, size limit)
- [x] All business logic enforced server-side

---

## Security Notes

- Passwords hashed with **bcrypt** (salt rounds built-in)
- File uploads validated by extension + `secure_filename()`
- Rating range validated server-side (1–10)
- All routes protected by decorators (`@login_required`, `@admin_required`)
- Duplicate rating blocked at DB constraint level
- Session secret key should be changed in production
