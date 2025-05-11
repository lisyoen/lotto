-- 사용자 테이블 생성
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

-- 로또 번호 테이블 수정
DROP TABLE IF EXISTS lotto_numbers;

CREATE TABLE IF NOT EXISTS lotto_numbers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    round INTEGER NOT NULL,
    number1 INTEGER NOT NULL,
    number2 INTEGER NOT NULL,
    number3 INTEGER NOT NULL,
    number4 INTEGER NOT NULL,
    number5 INTEGER NOT NULL,
    number6 INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
