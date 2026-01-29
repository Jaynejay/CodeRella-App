-- Insert sample users
-- Note: Passwords are hashed versions of the original passwords
INSERT INTO users (username, password, email, email_verified)
VALUES
('imashi', 'Imashi@1234', 'imashi@example.com', true),
('janani', 'Janani@1234', 'janani@example.com', true),
('jayani', 'Jayani@1234', 'jayani@example.com', true),
('isuri', 'Isuri@1234', 'isuri@example.com', true);

-- Insert a test user (password is 'password123')
-- INSERT INTO users (username, password, email, email_verified)
-- VALUES ('testuser', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG', 'test@example.com', true)
-- ON DUPLICATE KEY UPDATE username=username;
