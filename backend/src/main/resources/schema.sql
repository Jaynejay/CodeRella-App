DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    reset_token VARCHAR(255),
    reset_token_expiry DATETIME(6),
    email_verified BOOLEAN DEFAULT FALSE
); 