CREATE DATABASE QL_NHANVIEN
GO

USE QL_NHANVIEN;
GO

CREATE TABLE PHONG_BAN
(
	MAPB NVARCHAR (10) NOT NULL,
	TENPB NVARCHAR (50),
	DIADIEM NVARCHAR (50),
	PRIMARY KEY (MAPB)
)

CREATE TABLE NHANVIEN
(
	MANV NVARCHAR(10) NOT NULL,
	TENNV NVARCHAR(50),
	NGAYSINH DATE,
	DIACHI NVARCHAR (50),
	PHAI NVARCHAR (5),
	LUONG MONEY,
	MAPB NVARCHAR (10),
	PRIMARY KEY (MANV)
)
ALTER TABLE NHANVIEN ADD MANQL NVARCHAR (10);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_QL_NV FOREIGN KEY (MANQL) REFERENCES NHANVIEN(MANV);
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NV_PB FOREIGN KEY (MAPB) REFERENCES PHONG_BAN(MAPB);

CREATE TABLE DEAN
(
	MADA NVARCHAR(10) NOT NULL,
	TENDA NVARCHAR(50),
	DIADIEMDA NVARCHAR(50),
	NGAYBD DATE,
	PRIMARY KEY (MADA)
)

CREATE TABLE PHANCONG
(
	MADA NVARCHAR(10),
	MANV NVARCHAR(10),
	NGAYPC DATE
)
ALTER TABLE PHANCONG ADD CONSTRAINT FK_PC_DA FOREIGN KEY (MADA) REFERENCES DEAN (MADA);
ALTER TABLE PHANCONG ADD CONSTRAINT FK_PC_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV);

CREATE TABLE THANHNHAN
(
	MANV NVARCHAR (10),
	TENTN NVARCHAR (50),
	PHAI_TN NVARCHAR (5),
	NGAYSINH_TN DATE,
	QUANHE NVARCHAR (15)
)
ALTER TABLE THANHNHAN ADD CONSTRAINT FK_TN_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);

CREATE TABLE THENHANVIEN
(
	MANV NVARCHAR (10),
	NGAYCAP DATE
)
ALTER TABLE THENHANVIEN ADD CONSTRAINT FK_TNV_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);

--DROP TABLE IF EXISTS PHANCONG;
--DROP TABLE IF EXISTS THANHNHAN;
--DROP TABLE IF EXISTS DEAN;
--DROP TABLE IF EXISTS THENHANVIEN;
--DROP TABLE IF EXISTS NHANVIEN;
--DROP TABLE IF EXISTS PHONG_BAN;
--------------------PHONGBAN-----------------------------------
SELECT * FROM PHONG_BAN;
INSERT INTO PHONG_BAN(MAPB,TENPB,DIADIEM)
VALUES
	('PH001', N'Kế hoạch', N'Tầng 1 nhà A'),
    ('PH002', N'Quản trị', N'Tầng 1 nhà B'),
    ('PH003', N'Nhân sự', N'Tầng 2 nhà A'),
    ('PH004', N'Tài vụ', N'Tầng 3 nhà A'),
    ('PH005', N'Đầu tư', N'Tầng 2 nhà B'),
    ('PH006', N'Vật tư', N'Tầng 3 nhà B'),
    ('PH007', N'Tư vấn', N'Tầng 3 nhà B');
DELETE FROM PHONG_BAN WHERE MAPB = 'PH007';
----------------------------------------------------------------

--------------------NHANVIEN-----------------------------------
ALTER TABLE NHANVIEN NOCHECK CONSTRAINT FK_QL_NV;
ALTER TABLE NHANVIEN CHECK CONSTRAINT FK_QL_NV;
DELETE FROM NHANVIEN;
SELECT * FROM NHANVIEN;
INSERT INTO NHANVIEN (MANV, TENNV, NGAYSINH, DIACHI, PHAI, LUONG, MANQL, MAPB)
VALUES 
    ('NV0001', N'Nguyễn Văn Nam', '1988-07-12', N'Tây Ninh', N'Nam', 15000000, 'NV0009', 'PH003'),
    ('NV0002', N'Nguyễn Kim Ánh', '1990-02-10', N'TP.HCM', N'Nữ', 8000000, 'NV0009', 'PH003'),
    ('NV0003', N'Nguyễn Thị Châu', '1979-10-12', N'Vũng Tàu', N'Nữ', 12000000, 'NV0006', 'PH003'),
    ('NV0004', N'Trần Văn Út', '1977-08-23', N'Hà Nội', N'Nam', 7000000, 'NV0005', 'PH002'),
    ('NV0005', N'Trần Lệ Quyên', '1987-12-22', N'Hà Nội', N'Nữ', 9000000, 'NV0005', 'PH002'),
    ('NV0006', N'Bùi Đức Chí', '1987-11-10', N'TP.HCM', N'Nam', 10000000, 'NV0008', 'PH003'),
	('NV0007', N'Trần Nguyễn Phi Thông', '1987-11-10', N'TP.HCM', N'Nam', 10000000, 'NV0008', 'PH001'),
	('NV0008', N'Nguyễn Như Ý', '1987-12-10', N'TP.HCM', N'Nữ', 10000000, 'NV0009', 'PH001');
--Thay đổi địa chỉ của NV0006 thành Hà Nội
UPDATE NHANVIEN
SET DIACHI =N'Hà Nội'
WHERE MANV = 'NV0006';
--Thay đổi mã phòng ban của NV00011
UPDATE NHANVIEN
SET MAPB = 'PH001'
WHERE MANV = 'NV0001';
--Lọc những nhân viên có địa chỉ ở TP.HCM
SELECT TENNV, NGAYSINH, DIACHI
FROM NHANVIEN
WHERE DIACHI = N'TP.HCM';
--Tìm quản lý có nhân viên là nữ
SELECT TENNV, NGAYSINH, MANQL AS N'Người quản lý'
FROM NHANVIEN
WHERE PHAI = N'Nữ';
--Liệt kê những nhân viên thuộc phòng ban Kế hoạch
SELECT NHANVIEN.*
FROM NHANVIEN , PHONG_BAN
WHERE NHANVIEN.MAPB = PHONG_BAN.MAPB
	AND PHONG_BAN.TENPB = N'Kế hoạch';
--Tìm những nhân viên có tên bắt đầu hoặc trong tên có chữ Nguyễn
SELECT TENNV
FROM NHANVIEN
WHERE TENNV LIKE N'Nguyễn%' OR TENNV LIKE N'%Nguyễn%';
--Tính tổng lương của nhân viên phòng Nhân sự
SELECT SUM(NV.LUONG) AS 'Luong Trung Binh'
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB AND PB.TENPB = N'Nhân sự';
--Tính trung bình lương của nhân viên phòng Nhân sự
SELECT AVG(NV.LUONG) AS 'Tong luong'
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB AND PB.TENPB = N'Nhân sự';
--Đếm số lượng nhân viên từng phòng ban
SELECT PB.TENPB, COUNT(*) AS 'So Luong Nhan Vien'
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB
GROUP BY (PB.TENPB);
--Liệt kê phòng ban có 3 nhân viên trở lên
SELECT PB.TENPB
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB
GROUP BY (PB.TENPB)
HAVING COUNT(*) > 3;
--Sắp xếp nhân viên theo ngày sinh
SELECT NV.TENNV, YEAR(NV.NGAYSINH) AS 'NAMSINH', NV.DIACHI
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB
ORDER BY YEAR(NV.NGAYSINH) ASC, NV.TENNV DESC; 
--Tìm phòng ban có số lượng nhân viên đông nhất
SELECT PB.TENPB
FROM NHANVIEN NV, PHONG_BAN PB
WHERE NV.MAPB = PB.MAPB
GROUP BY PB.TENPB
HAVING COUNT(*) >= ALL(
					SELECT COUNT(*)
					FROM NHANVIEN NV
					GROUP BY NV.MAPB
					)
--Kết hợp thông tin nhân viên với thân nhân
SELECT MANV 'MA NV', TENNV 'HO TEN'
FROM NHANVIEN
UNION
SELECT MANV 'MA NV', TENTN 'HO TEN'
FROM THANHNHAN
--Sắp tên thân nhân
SELECT MANV ' MA NV', TENNV 'HO TEN'
FROM NHANVIEN
UNION
SELECT MANV 'MA NV', TENTN 'HO TEN'
FROM THANHNHAN
ORDER BY [HO TEN], MANV;
--Nhân viên được phân công đề án
SELECT MANV FROM NHANVIEN
INTERSECT
SELECT MANV FROM PHANCONG
--Nhân viên chưa được phân công đề án
SELECT MANV FROM NHANVIEN
EXCEPT
SELECT MANV FROM PHANCONG
--Thông tin nhân viên ở phòng quản trị
SELECT NV.*
FROM NHANVIEN NV
INNER JOIN PHONG_BAN PB ON NV.MAPB = PB.MAPB
WHERE PB.TENPB = N'Quản trị'
--Cho biết họ tên nhân viên và tình trạng phân công thực hiện đề án (MADA, NGAYPC)
SELECT NV.TENNV, PC.MADA, PC.NGAYPC
FROM NHANVIEN NV
LEFT JOIN PHANCONG PC ON NV.MANV = PC.MANV;
--Những nhân viên chưa được phân công đề án nào
SELECT NV.TENNV, PC.MADA
FROM NHANVIEN NV
LEFT JOIN PHANCONG PC ON NV.MANV = PC.MANV
WHERE PC.MADA IS NULL;
--Cho biết tên, mã nhân viên mã đề án đã được phân công
SELECT NV.MANV, NV.TENNV, PC.MADA
FROM NHANVIEN NV
RIGHT OUTER JOIN PHANCONG PC ON NV.MANV = PC.MANV;
--Cho biết họ tên, mã nhân viên tương ứng với từng phồng ban
SELECT NV.MANV, NV.TENNV, PB.MAPB
FROM NHANVIEN NV
FULL OUTER JOIN PHONG_BAN PB ON NV.MAPB = PB.MAPB;
----------------------------------------------------------------
-- Câu 14: Hiển thị cấu trúc bảng PhongBan
EXEC sp_help 'PHONG_BAN';
-- Câu 15: Hiển thị cấu trúc bảng NhanVien
EXEC sp_help 'NHANVIEN';
-- Câu 16: Hiển thị cấu trúc bảng DeAn
EXEC sp_help 'DEAN';
-- Câu 17: Hiển thị cấu trúc bảng PhanCong
EXEC sp_help 'PHANCONG';
-- Câu 18: Hiển thị cấu trúc bảng ThanNhan
EXEC sp_help 'THANNHAN';
-- Câu 19: Hiển thị cấu trúc bảng TheNhanVien
EXEC sp_help 'THENHANVIEN';
--------------------DEAN-----------------------------------
SELECT * FROM DEAN;
INSERT INTO DEAN (MADA, TENDA, DIADIEMDA, NGAYBD)
VALUES 
    ('DA001', N'Đền bù giải toả', N'Phường 12, Q. Tân Bình', '2015-01-01'),
    ('DA002', N'Giải phóng mặt bằng', N'Phường 12, Q. Tân Bình', '2015-06-01'),
    ('DA003', N'Cải tạo mặt đường số 9', N'Phường Tây Thạnh, Q. Tân Phú', '2016-01-01'),
    ('DA004', N'Bắt đầu thi công', N'Phường 26, Q. Bình Thạnh', '2016-05-04'),
    ('DA005', N'Hoàn thiện mặt bằng', N'Phường Tân Quy, Quận 7', '2016-12-10');
----------------------------------------------------------------

--------------------PHANCONG-----------------------------------
SELECT * FROM PHANCONG;
INSERT INTO PHANCONG (MANV, MADA, NGAYPC)
VALUES 
    ('NV0001', 'DA001', '2015-02-05'),
    ('NV0001', 'DA003', '2016-03-17'),
    ('NV0003', 'DA003', '2016-01-01'),
    ('NV0005', 'DA004', '2016-05-10'),
    ('NV0007', 'DA005', '2016-12-20');
ALTER TABLE PHANCONG NOCHECK CONSTRAINT FK_PC_NV, FK_PC_DA;
----------------------------------------------------------------

--------------------THANHNHAN-----------------------------------
SELECT * FROM THANHNHAN;
INSERT INTO THANHNHAN (MANV, TENTN, PHAI_TN, NGAYSINH_TN, QUANHE)
VALUES 
    ('NV0001', N'Nguyễn Văn Bình', N'Nam', '1983-05-22', N'Anh'),
    ('NV0002', N'Nguyễn Chính Nghĩa', N'Nam', '1998-03-07', N'Em'),
    ('NV0005', N'Lê Anh Hùng', N'Nam', '1978-04-05', N'Chồng'),
    ('NV0006', N'Bùi Đại An', N'Nam', '1976-12-03', N'Anh'),
    ('NV0008', N'Lê Thảo Nguyên', N'Nữ', '1985-06-12', N'Vợ'),
    ('NV0009', N'Trần Thanh Nhàn', N'Nữ', '1979-05-30', N'Chị');
ALTER TABLE THANHNHAN NOCHECK CONSTRAINT FK_TN_NV;
----------------------------------------------------------------

--------------------THENHANVIEN-----------------------------------
SELECT * FROM THENHANVIEN;
INSERT INTO THENHANVIEN (MANV, NGAYCAP)
VALUES 
    ('NV0001', '2018-03-05'),
    ('NV0002', '2019-03-17'),
    ('NV0003', '2020-01-01'),
    ('NV0004', '2020-05-10'),
    ('NV0005', '2021-12-20');
----------------------------------------------------------------