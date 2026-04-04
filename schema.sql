-- ============================================================
--  Image Rater — MySQL Schema
--  Run this in phpMyAdmin or via: mysql -u root -p < schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS image_rater
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE image_rater;

-- ── USERS ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('admin','user') NOT NULL DEFAULT 'user',
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ── IMAGES ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS images (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    image_name  VARCHAR(150) NOT NULL,
    image_path  VARCHAR(255) NOT NULL,
    uploaded_by INT UNSIGNED NOT NULL,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_img_user FOREIGN KEY (uploaded_by)
        REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ── RATINGS ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS ratings (
    id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id   INT UNSIGNED NOT NULL,
    image_id  INT UNSIGNED NOT NULL,
    rating    TINYINT UNSIGNED NOT NULL CHECK (rating BETWEEN 1 AND 10),
    rated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_rat_user  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
    CONSTRAINT fk_rat_image FOREIGN KEY (image_id) REFERENCES images(id) ON DELETE CASCADE,
    CONSTRAINT uq_user_image UNIQUE (user_id, image_id)   -- one rating per image per user
) ENGINE=InnoDB;

-- ── USER RATING SESSION ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS user_rating_session (
    user_id          INT UNSIGNED PRIMARY KEY,
    ratings_count    TINYINT UNSIGNED NOT NULL DEFAULT 0,
    last_rating_time DATETIME DEFAULT NULL,
    cooldown_until   DATETIME DEFAULT NULL,
    CONSTRAINT fk_sess_user FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ── INDEXES for performance ───────────────────────────────────
CREATE INDEX idx_ratings_user  ON ratings (user_id);
CREATE INDEX idx_ratings_image ON ratings (image_id);
CREATE INDEX idx_images_uploader ON images (uploaded_by);
