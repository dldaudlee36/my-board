-- posts 테이블 및 자동 증가 시퀀스
CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY DEFAULT nextval('posts_id_seq'),
    title TEXT NOT NULL,
    body TEXT NOT NULL
);

-- users 테이블 (로그인 실습용)
CREATE TABLE IF NOT EXISTS users (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);
