SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- Dọn dẹp nếu import lại
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- USERS (password_hash dùng password_hash() => cần VARCHAR(255))
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(120) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  role ENUM('admin','user') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CATEGORIES (mã chuẩn + tên hiển thị tiếng Việt)
CREATE TABLE categories (
  code VARCHAR(20) PRIMARY KEY,       -- AO / QUAN / VAY / DAM / AO_KHOAC ...
  name_vi VARCHAR(50) NOT NULL,       -- Áo / Quần / Váy / Đầm / Áo khoác ...
  sort_order INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PRODUCTS (lưu category_code và FK sang categories)
CREATE TABLE products (
  product_code VARCHAR(50) PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  category_code VARCHAR(20) NOT NULL,
  size VARCHAR(10) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  description TEXT,
  image VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT fk_products_category
    FOREIGN KEY (category_code) REFERENCES categories(code)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed categories
INSERT INTO categories (code, name_vi, sort_order) VALUES
('AO', 'Áo', 1),
('QUAN', 'Quần', 2),
('VAY', 'Váy', 3),
('DAM', 'Đầm', 4),
('AO_KHOAC', 'Áo khoác', 5);

-- Seed products (dùng category_code chuẩn)
INSERT INTO products (product_code, product_name, category_code, size, price, quantity, description, image) VALUES
('SP001', 'Áo thun basic trắng', 'AO', 'M', 150000, 50, 'Áo thun cotton 100%, form regular', NULL),
('SP007', 'Quần jean slim fit', 'QUAN', 'L', 450000, 30, 'Quần jean co giãn, ôm dáng', NULL),
('SP011', 'Váy denim ngắn', 'VAY', 'S', 320000, 20, 'Váy jean ngắn, phong cách trẻ trung', NULL),
('SP015', 'Áo khoác bomber', 'AO_KHOAC', 'L', 580000, 20, 'Bomber jacket, chất liệu dù', NULL),
('SP019', 'Áo tank top gym', 'AO', 'M', 95000, 70, 'Áo ba lỗ thể thao, thấm hút mồ hôi', NULL);

-- Index
CREATE INDEX idx_products_name ON products(product_name);
CREATE INDEX idx_products_category ON products(category_code);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);

-- Seed admin/user:
-- KHÔNG insert password ở đây nếu bạn chưa đổi code sang password_hash().
-- Sau khi đổi code, bạn hãy đăng ký bằng form hoặc tự INSERT với password_hash tạo từ PHP.
