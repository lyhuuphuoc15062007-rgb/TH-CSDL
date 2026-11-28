CREATE DATABASE QL_LINHKIEN;
GO

USE QL_LINHKIEN;
GO

CREATE TABLE LOAILK
(
	MALOAI NVARCHAR(10) PRIMARY KEY,
	TENLOAI NVARCHAR(50)
)

CREATE TABLE LINHKIEN
(
	MALK NVARCHAR (10) PRIMARY KEY,
	TENLK NVARCHAR (50),
	NGAYSX DATE,
	TGBH INT,
	MALOAI NVARCHAR (10),
	NSX NVARCHAR (50),
	DVT NVARCHAR (10),
)
ALTER TABLE LINHKIEN ADD CONSTRAINT FK_LK_LLK FOREIGN KEY (MALOAI) REFERENCES LOAILK(MALOAI);

CREATE TABLE KHACHHANG
(
	MAKH NVARCHAR (10) PRIMARY KEY,
	TENKH NVARCHAR (50),
	DCHI NVARCHAR (50),
	DTHOAI NVARCHAR (13)
)

CREATE TABLE HOADON
(
	MAHD NVARCHAR (10) PRIMARY KEY,
	NGAYHD DATE,
	MAKH NVARCHAR (10),
	CONSTRAINT FK_HD_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
	TONGTIEN MONEY
)

CREATE TABLE CHITIETHD
(
	MAHD NVARCHAR (10),
	CONSTRAINT FK_CTHD_HD FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD),
	MALK NVARCHAR (10),
	CONSTRAINT FK_CTHD_LK FOREIGN KEY (MALK) REFERENCES LINHKIEN(MALK),
	SOLUONG INT,
	DONGIA MONEY,
)

------------------------------------------------------
SELECT * FROM LOAILK;
INSERT INTO LOAILK (MALOAI, TENLOAI) VALUES 
    ('MOU', N'Chuột'),
    ('LAP', N'Máy tính xách tay'),
    ('CPU', N'Bộ xử lý'),
    ('PCX', N'Máy tính để bàn'),
    ('MAI', N'Mainboard');
------------------------------------------------------
SELECT * FROM LINHKIEN;
INSERT INTO LINHKIEN (MALK, TENLK, NGAYSX, TGBH, MALOAI, NSX, DVT)
VALUES 
    ('MOU001', N'Chuột quang có dây', '2014-01-01', 12, 'MOU', N'Genius', N'Cái'),
    ('MOU002', N'Chuột quang không dây', '2015-02-04', 12, 'MOU', N'Mitsumi', N'Cái'),
    ('MOU003', N'Chuột không dây', '2014-04-02', 24, 'MOU', N'Abroad', N'Cái'),
    ('CPU001', N'CPU ADM', '2015-04-05', 24, 'CPU', N'Abroad', N'Cái'),
    ('CPU002', N'CPU INTEL', '2016-02-07', 36, 'CPU', N'Mitsumi', N'Cái'),
    ('CPU003', N'CPU ASUS', '2015-12-08', 36, 'CPU', N'Abroad', N'Cái'),
    ('MAI001', N'Mainboard ASUS', '2015-12-04', 36, 'MAI', N'Mitsumi', N'Cái'),
    ('MAI002', N'Mainboard ATXX', '2016-03-03', 12, 'MAI', N'Mitsumi', N'Cái'),
    ('MAI003', N'Mainboard ACER', '2015-04-14', 12, 'MAI', N'Genius', N'Cái'),
    ('PCX001', N'Acer 20144', '2015-10-19', 12, 'PCX', N'Acer', N'Bộ');
------------------------------------------------------
SELECT * FROM KHACHHANG;
INSERT INTO KHACHHANG (MAKH, TENKH, DCHI, DTHOAI)
VALUES 
    ('KH001', N'Nguyễn Thu Tâm', N'Tây Ninh', '0989751723'),
    ('KH002', N'Đinh Bảo Lộc', N'Lâm Đồng', '0918234654'),
    ('KH003', N'Trần Thanh Diệu', N'TP. HCM', '0978123765'),
    ('KH004', N'Hồ Tuấn Thành', N'Hà Nội', '0909456768'),
    ('KH005', N'Huỳnh Kim Ánh', N'Khánh Hòa', '0932987567');
------------------------------------------------------
INSERT INTO HOADON (MAHD, NGAYHD, MAKH, TONGTIEN)
VALUES 
    ('HD001', '2015-04-01', 'KH001', NULL),
    ('HD002', '2016-05-15', 'KH005', NULL),
    ('HD003', '2016-06-14', 'KH004', NULL),
    ('HD004', '2016-06-03', 'KH005', NULL),
    ('HD005', '2016-06-05', 'KH001', NULL),
    ('HD006', '2016-07-07', 'KH003', NULL),
    ('HD007', '2016-08-12', 'KH002', NULL),
    ('HD008', '2016-09-25', 'KH003', NULL);
------------------------------------------------------
INSERT INTO CHITIETHD (MAHD, MALK, SOLUONG, DONGIA)
VALUES 
    ('HD001', 'MOU001', 2, 1000000),
    ('HD002', 'MOU002', 1, 2000000),
    ('HD003', 'MOU003', 6, 3000000),
    ('HD004', 'CPU001', 5, 500000),
    ('HD005', 'CPU002', 6, 560000),
    ('HD006', 'CPU003', 3, 400000),
    ('HD006', 'MAI001', 1, 200000),
    ('HD007', 'MAI002', 1, 150000),
    ('HD007', 'MAI003', 2, 160000),
    ('HD007', 'MOU001', 1, 1000000),
    ('HD008', 'CPU001', 2, 500000);

SELECT * FROM HOADON;
SELECT * FROM CHITIETHD;