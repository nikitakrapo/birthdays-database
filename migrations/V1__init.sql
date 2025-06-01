CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Birthdays app users
CREATE TABLE users (
    uid TEXT PRIMARY KEY,  -- Firebase UID
    display_name TEXT NOT NULL,
    birthday_date DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Friendships (user A is friends with user B)
CREATE TABLE user_friends (
    user_uid TEXT NOT NULL,      -- who has the friend
    friend_uid TEXT NOT NULL,    -- the friend (also a user)

    PRIMARY KEY (user_uid, friend_uid),

    FOREIGN KEY (user_uid) REFERENCES users(uid) ON DELETE CASCADE,
    FOREIGN KEY (friend_uid) REFERENCES users(uid) ON DELETE CASCADE
);

-- Manual birthday entries (not linked to a user)
CREATE TABLE local_birthdays (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_uid TEXT NOT NULL,         -- who created this
    display_name TEXT NOT NULL,
    birthday_date DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),

    FOREIGN KEY (owner_uid) REFERENCES users(uid) ON DELETE CASCADE
);
