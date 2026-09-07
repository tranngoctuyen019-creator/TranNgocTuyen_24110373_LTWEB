USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ServletCRUDMVC')
BEGIN
    ALTER DATABASE ServletCRUDMVC SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ServletCRUDMVC;
END
GO
CREATE DATABASE ServletCRUDMVC;
GO
USE ServletCRUDMVC;
GO

CREATE TABLE [Category] (
    cate_id    INT IDENTITY(1,1) PRIMARY KEY,
    cate_name  NVARCHAR(255) NOT NULL,
    icons      NVARCHAR(255) NULL
);
GO

CREATE TABLE [Account] (
    acc_id      INT IDENTITY(1,1) PRIMARY KEY,
    username    NVARCHAR(100)  NOT NULL,
    password    NVARCHAR(255)  NOT NULL,
    email       NVARCHAR(150)  NOT NULL,
    full_name   NVARCHAR(255)  NULL,
    phone       NVARCHAR(20)   NULL,  
    avatar      NVARCHAR(255)  NULL,  
    active      BIT            NOT NULL DEFAULT(0),
    otp_code    NVARCHAR(10)   NULL,
    otp_expiry  DATETIME2      NULL,
    created_at  DATETIME2      NULL,
    CONSTRAINT UQ_Account_username UNIQUE (username),
    CONSTRAINT UQ_Account_email    UNIQUE (email)
);
GO

CREATE TABLE [Product] (
    pro_id       INT IDENTITY(1,1) PRIMARY KEY,
    pro_name     NVARCHAR(255)   NOT NULL,
    price        DECIMAL(18,2)   NOT NULL,
    quantity     INT             NOT NULL DEFAULT(0),
    description  NVARCHAR(2000)  NULL,
    image        NVARCHAR(255)   NULL,
    created_at   DATETIME2       NULL,
    cate_id      INT             NOT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (cate_id)
        REFERENCES [Category](cate_id)
);
GO

INSERT INTO [Category] (cate_name, icons) VALUES
(N'Điện thoại', NULL),
(N'Laptop', NULL),
(N'Phụ kiện', NULL);
GO

INSERT INTO [Account] (username, password, email, full_name, phone, avatar, active, otp_code, otp_expiry, created_at) VALUES
(N'admin', N'123456', N'admin@example.com', N'Quản trị viên', N'0908617108', NULL, 1, NULL, NULL, GETDATE()),
(N'user01', N'123456', N'user01@example.com', N'Nguyễn Văn A', N'0912345678', NULL, 1, NULL, NULL, GETDATE());
GO

INSERT INTO [Product]
(pro_name, price, quantity, description, image, created_at, cate_id)
VALUES
(N'iPhone 15 Pro Max', 29990000, 10, N'Điện thoại flagship của Apple, chip A17 Pro.', NULL, GETDATE(), 1),
(N'Samsung Galaxy S24', 21990000, 15, N'Flagship Android với camera AI vượt trội.', NULL, GETDATE(), 1),
(N'Xiaomi 14', 15990000, 20, N'Hiệu năng mạnh mẽ, camera Leica, giá hợp lý.', NULL, GETDATE(), 1),
(N'OPPO Find X7', 18990000, 12, N'Thiết kế cao cấp, camera Hasselblad.', NULL, GETDATE(), 1),
(N'MacBook Air M3', 27990000, 8, N'Laptop mỏng nhẹ, hiệu năng mạnh mẽ với chip M3.', NULL, GETDATE(), 2),
(N'Dell XPS 13', 25990000, 5, N'Laptop cao cấp, màn hình InfinityEdge.', NULL, GETDATE(), 2),
(N'Asus ROG Zephyrus', 39990000, 6, N'Laptop gaming hiệu năng cao, RTX 4070.', NULL, GETDATE(), 2),
(N'Lenovo ThinkPad X1', 32990000, 7, N'Laptop doanh nhân bền bỉ, bảo mật cao.', NULL, GETDATE(), 2),
(N'Ốp lưng iPhone 15', 250000, 50, N'Ốp lưng silicon chống sốc.', NULL, GETDATE(), 3),
(N'Tai nghe Bluetooth', 990000, 30, N'Tai nghe không dây chống ồn chủ động.', NULL, GETDATE(), 3);
GO