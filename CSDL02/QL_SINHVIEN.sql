CREATE DATABASE QL_SINHVIEN;
GO

USE QL_SINHVIEN
GO

CREATE TABLE KHOA
(
	MAKH NVARCHAR (10) PRIMARY KEY,
	TENKH NVARCHAR (50)
)

CREATE TABLE LOP
(
	MALOP NVARCHAR (10) PRIMARY KEY,
	TENLOP NVARCHAR (50),
	SISO INT,
	LOPTRUONG NVARCHAR (50),
	MAKH NVARCHAR (10),
	CONSTRAINT FK_LOP_KHOA FOREIGN KEY (MAKH) REFERENCES KHOA(MAKH)
)

CREATE TABLE SINHVIEN
(
	MASV NVARCHAR (10) PRIMARY KEY,
	HOTEN NVARCHAR (50),
	NGAYSINH DATE,
	GIOITINH NVARCHAR (5),
	DIACHI NVARCHAR (50),
	MALOP NVARCHAR (10),
	CONSTRAINT FK_LOP_SV FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
)

CREATE TABLE GIANGVIEN
(
	MAGV NVARCHAR (10) PRIMARY KEY,
	TENGV NVARCHAR (50),
	MAKH NVARCHAR (10),
	CONSTRAINT FK_KHOA_GV FOREIGN KEY (MAKH) REFERENCES KHOA(MAKH)
)

CREATE TABLE MONHOC
(
	MAMH NVARCHAR (10) PRIMARY KEY,
	TENMH NVARCHAR (50),
	SOTC INT
)

CREATE TABLE DIEM
(
	MASV NVARCHAR (10),
	CONSTRAINT FK_DIEM_SV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
	MAMH NVARCHAR (10),
	CONSTRAINT FK_DIEM_MH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	LANTHI INT,
	DIEMTHI FLOAT
)

CREATE TABLE GIANGDAY
(
	HOCKY INT,
	NAMHOC NVARCHAR (10),
	MAGV NVARCHAR(10),
	MAMH NVARCHAR (10),
	CONSTRAINT FK_GD_MH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT FK_GD_GV FOREIGN KEY (MAGV) REFERENCES GIANGVIEN(MAGV)
)

CREATE TABLE THANHNHAN
(
	MATN NVARCHAR (10) PRIMARY KEY,
	HOTENTN NVARCHAR (50),
	GIOITINH NVARCHAR (5)
)

CREATE TABLE QUANHE
(
	MATN NVARCHAR (10),
	CONSTRAINT FK_QH_TN FOREIGN KEY (MATN) REFERENCES THANHNHAN(MATN),
	MASV NVARCHAR (10),
	CONSTRAINT FK_QH_SV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
	MOIQUANHE NVARCHAR (10)
)

--Bảng KHOA
SELECT * FROM KHOA;
INSERT INTO KHOA(MAKH,TENKH) VALUES
('SH', N'Công nghệ sinh học'),
('TH',N'Công nghệ thông tin'),
('TP',N'Công nghệ sinh học'),
('QT',N'Quản trị kinh doanh'),
('TC',N'Tài chính kế toán');
UPDATE  KHOA
SET TENKH = N'Công nghệ thực phẩm'
WHERE MAKH = 'TP';

-- Bảng LOP
SELECT * FROM LOP;
INSERT INTO LOP (MALOP, TENLOP, SISO, LOPTRUONG, MAKH) VALUES
('10DHSH1', N'10 Đại học Sinh học 1', 55, 'SV008', 'SH'),
('10DHTH1', N'10 Đại học Tin học 1', 50, 'SV001', 'TH'),
('11DHTH2', N'11 Đại học Tin học 2', 40, 'SV005', 'TH'),
('12DHTC1', N'12 Đại học Tài chính 1', 75, 'SV009', 'TC'),
('12DHTP1', N'12 Đại học Thực phẩm 1', 60, 'SV007', 'TP');

-- Bảng SINHVIEN
SELECT * FROM SINHVIEN;
INSERT INTO SINHVIEN (MASV, HOTEN, NGAYSINH, GIOITINH, DIACHI, MALOP) VALUES
('SV001', N'Trần Lệ Quyên', '1995-01-21', N'Nữ', N'TPHCM', '10DHTH1'),
('SV002', N'Nguyễn Thế Bình', '1996-06-04', N'Nam', N'Tây Ninh', '11DHTH2'),
('SV003', N'Tô Ánh Nguyệt', '1995-05-02', N'Nữ', N'Vũng Tàu', '12DHTP1'),
('SV004', N'Nguyễn Thế Anh', '1996-12-15', N'Nam', N'Đồng Nai', '12DHTP1'),
('SV005', N'Lê Thanh Bình', '1994-12-09', N'Nam', N'Long An', '10DHTH1'),
('SV006', N'Phạm Quang Hậu', '1995-10-12', N'Nam', N'Tây Ninh', '10DHTH1'),
('SV007', N'Lê Cẩm Tú', '1989-02-13', N'Nữ', N'Bình Thuận', '12DHTP1'),
('SV008', N'Trương Thế Sang', '1993-04-04', N'Nam', N'Bình Dương', '10DHSH1'),
('SV009', N'Đậu Quang Ánh', '1994-12-03', N'Nam', N'Long An', '12DHTC1'),
('SV010', N'Huỳnh Kim Chi', '1996-10-18', N'Nữ', N'TPHCM', '11DHTH2'),
('SV011', N'Trịnh Đình Ánh', '1995-11-15', N'Nam', N'Bình Thuận', '10DHTH1');

-- Bảng GIANGVIEN
SELECT * FROM GIANGVIEN;
INSERT INTO GIANGVIEN (MAGV, TENGV, MAKH) VALUES
('GV001', N'Phạm Thế Bảo', 'TH'),
('GV002', N'Lê Thế Truyền', 'TH'),
('GV003', N'Trương Anh Dũng', 'SH'),
('GV004', N'Bùi Chí Anh', 'TC'),
('GV005', N'Lê Công Hậu', 'QT'),
('GV006', N'Lê Trung Thành', 'TP');

-- Bảng MONHOC
SELECT * FROM MONHOC;
INSERT INTO MONHOC (MAMH, TENMH, SOTC) VALUES
('CSDL', N'Cơ sở dữ liệu', 3),
('KTLT', N'Kỹ thuật lập trình', 3),
('THVP', N'Tin học văn phòng', 3),
('TRR', N'Toán rời rạc', 3),
('TTNT', N'Trí tuệ nhân tạo', 2),
('TTQT', N'Thanh toán quốc tế', 2);

-- Bảng DIEM
SELECT * FROM DIEM;
INSERT INTO DIEM (MASV, MAMH, LANTHI, DIEMTHI) VALUES
('SV001', 'CSDL', 1, 9),
('SV002', 'THVP', 1, 3),
('SV002', 'THVP', 2, 7),
('SV004', 'THVP', 1, 6),
('SV004', 'TTQT', 1, 5),
('SV005', 'CSDL', 1, 3),
('SV005', 'CSDL', 2, 6),
('SV006', 'KTLT', 1, 4),
('SV009', 'TTQT', 1, 4),
('SV010', 'THVP', 1, 8),
('SV010', 'TRR', 1, 7);

-- Bảng GIANGDAY
SELECT * FROM GIANGDAY;
INSERT INTO GIANGDAY (MAGV, MAMH, NAMHOC, HOCKY) VALUES
('GV001', 'CSDL', '2021-2022', 1),
('GV001', 'KTLT', '2020-2021', 2),
('GV001', 'TTNT', '2020-2021', 1),
('GV002', 'CSDL', '2021-2022', 2),
('GV002', 'KTLT', '2021-2022', 2);

-- Bảng THANNHAN
SELECT * FROM THANHNHAN;
INSERT INTO THANHNHAN(MATN, HOTENTN, GIOITINH) VALUES
('TN001', N'Nguyễn Thế Thành', N'Nam'),
('TN002', N'Tô Ánh Hồng', N'Nữ'),
('TN003', N'Lê Thanh An', N'Nam'),
('TN004', N'Phạm Thanh Tiền', N'Nữ'),
('TN006', N'Đậu Văn Thanh', N'Nam'),
('TN007', N'Nguyễn Thị Ánh', N'Nữ'),
('TN008', N'Lê Quang Định', N'Nam'),
('TN009', N'Huỳnh Văn Tư', N'Nam');

-- Bảng QUANHE
SELECT * FROM QUANHE;
INSERT INTO QUANHE (MATN, MASV, MOIQUANHE) VALUES
('TN001', 'SV002', N'Bố'),
('TN004', 'SV005', N'Mẹ'),
('TN004', 'SV007', N'Mẹ'),
('TN006', 'SV009', N'Bố'),
('TN007', 'SV002', N'Mẹ'),
('TN008', 'SV005', N'Bố'),
('TN008', 'SV007', N'Bố');

--1. Cập nhật địa chỉ của sinh viên có mã số SV002 là ‘CẦN THƠ’.
UPDATE SINHVIEN
SET DIACHI = N'Cần Thơ'
WHERE MASV = 'SV002';
--2. Tạo bảng ảo lưu trữ danh sách sinh viên (Mã SV, họ tên), tên lớp tương ứng của sinh viên.
GO
CREATE VIEW SV_DSSV
AS
	SELECT SV.MASV, SV.HOTEN, L.TENLOP
	FROM SINHVIEN SV , LOP L
	WHERE SV.MALOP = L.MALOP;
SELECT * FROM SV_DSSV;
--3. Liệt kê danh sách sinh viên (Mã SV, Họ tên) của những sinh viên có địa chỉ ở Vũng Tàu.
SELECT MASV, HOTEN
FROM SINHVIEN
WHERE DIACHI = N'Vũng Tàu';
--4. Cho biết số tín chỉ của môn Toán rời rạc?
SELECT SOTC
FROM MONHOC
WHERE TENMH = N'Toán rời rạc';
--5. Cho biết danh sách các lớp (Tên lớp) thuộc khoa Công nghệ Thông tin?
SELECT L.TENLOP
FROM LOP L, KHOA K
WHERE L.MAKH = K.MAKH;
--6. Cho biết danh sách sinh viên (Mã SV, họ tên) của những sinh viên nam có họ “Nguyễn”?
SELECT SV.*
FROM SINHVIEN SV
WHERE SV.HOTEN LIKE N'Nguyễn%' AND SV.GIOITINH = N'Nam';
--7. Cho biết họ tên, ngày sinh, địa chỉ của những sinh viên nam học lớp 10DHTH1?
SELECT MASV, HOTEN, NGAYSINH,DIACHI
FROM SINHVIEN
WHERE MALOP = N'10DHTH1';
--8. Cho biết tên những môn học có 1 hoặc 2 tín chỉ?
SELECT TENMH
FROM MONHOC
WHERE SOTC = '1' OR SOTC = '2';
--9. Cho biết họ tên, địa chỉ những sinh viên nữ thuộc khoa Công nghệ Thông tin?
SELECT SV.HOTEN,SV.DIACHI
FROM SINHVIEN SV, LOP L, KHOA K
WHERE SV.MALOP = L.MALOP AND L.MAKH = K.MAKH
AND K.TENKH = N'Công nghệ thông tin' AND SV.GIOITINH = N'Nữ';
--10. Cho biết tên những sinh viên nữ có địa chỉ ở TP. HCM hoặc Vũng Tàu?
SELECT HOTEN, DIACHI
FROM SINHVIEN
WHERE GIOITINH = N'Nữ' AND (DIACHI = N'TPHCM' OR DIACHI = N'Vũng Tàu');
--11. Cho biết họ tên những sinh viên lớp 10DHTH1 có điểm thi trong khoảng từ 6 đến 8?'
--Cách 1:
SELECT SV.*, D.DIEMTHI
FROM SINHVIEN SV, LOP L, DIEM D
WHERE SV.MALOP = L.MALOP AND L.MALOP ='10DHTH1'
		AND SV.MASV = D.MASV AND (D.DIEMTHI BETWEEN 6 AND 8);
--Cách 2: dùng JOIN
SELECT SV.*, D.DIEMTHI
FROM SINHVIEN SV
INNER JOIN LOP L ON SV.MALOP = L.MALOP
INNER JOIN DIEM D ON SV.MASV = D.MASV
WHERE L.MALOP = '10DHTH1' AND (D.DIEMTHI BETWEEN 6 AND 8);
--12. Cho biết những sinh viên khoa Công nghệ Thông tin học môn CSDL có điểm thi lớn hơn 5?
SELECT SV.*, D.DIEMTHI, MH.TENMH
FROM SINHVIEN SV
INNER JOIN LOP L ON SV.MALOP = L.MALOP
INNER JOIN KHOA K ON L.MAKH = K.MAKH
INNER JOIN DIEM D ON SV.MASV = D.MASV
INNER JOIN MONHOC MH ON D.MAMH = MH.MAMH
WHERE K.TENKH = N'Công nghệ thông tin' AND MH.TENMH = N'Cơ sở dữ liệu' AND D.DIEMTHI >= 5;
--13. Liệt kê danh sách tên khoa và số lượng lớp trong từng khoa.
SELECT K.TENKH, COUNT(*) AS 'SO LUONG LOP'
FROM LOP L, KHOA K
WHERE K.MAKH = L.MAKH
GROUP BY (K.TENKH);
--14. Liệt kê danh sách tên lớp và số lượng sinh viên trong từng lớp.
SELECT L.TENLOP,COUNT(*) AS 'SO LUONG SV'
FROM LOP L, SINHVIEN SV
WHERE SV.MALOP = L.MALOP
GROUP BY (L.TENLOP);
--15. Liệt kê danh sách tên khoa và số lượng sinh viên trong từng khoa. 
--Sắp xếp các khoa theo thứ tự số lượng sinh viên tăng dần.
SELECT K.TENKH, COUNT(*) AS 'SO LUONG SV THEO TUNG KHOA'
FROM KHOA K, LOP L, SINHVIEN SV
WHERE K.MAKH = L.MAKH AND L.MALOP = SV.MALOP
GROUP BY (K.TENKH)
ORDER BY COUNT(*) ASC;
--16. Liệt kê mã sinh viên, họ tên và điểm trung bình của từng sinh viên.
SELECT SV.MASV, SV.HOTEN, AVG(D.DIEMTHI) AS 'DIEM TRUNG BINH'
FROM SINHVIEN SV, DIEM D
WHERE SV.MASV = D.MASV
GROUP BY SV.MASV,SV.HOTEN;
--17. Cho biết họ tên và tổng số môn học của từng sinh viên nam đã học.
SELECT SV.HOTEN, COUNT(MH.MAMH) AS 'TONG SO MON HOC'
FROM SINHVIEN SV, MONHOC MH, DIEM D
WHERE SV.GIOITINH = N'Nam' AND SV.MASV = D.MASV AND MH.MAMH = D.MAMH
GROUP BY SV.MASV, SV.HOTEN;
--18. Cho biết những khoa có ít nhất 2 lớp?
SELECT K.TENKH, COUNT(K.MAKH) AS 'SO LUONG LOP'
FROM KHOA K, LOP L
WHERE K.MAKH = L.MAKH
GROUP BY K.MAKH, K.TENKH
HAVING COUNT (*) >= 2;
--19. Cho biết những lớp có ít nhất 2 sinh viên?
SELECT L.TENLOP, COUNT(L.MALOP) AS 'SO LUONG SV'
FROM SINHVIEN SV, LOP L
WHERE SV.MALOP = L.MALOP
GROUP BY L.MALOP, L.TENLOP
HAVING COUNT (*) >= 2;
--20. Cho biết danh sách các khoa (TENKHOA) có số lượng sinh viên dưới 500 người
SELECT K.TENKH, COUNT(K.MAKH) AS 'SO LUONG SV THEO TUNG KHOA'
FROM SINHVIEN SV, LOP L, KHOA K
WHERE SV.MALOP = L.MALOP AND L.MAKH = K.MAKH
GROUP BY K.MAKH, K.TENKH
HAVING COUNT(*) < 500;
--21. Cho biết tên những môn học có số tín chỉ lớn hơn 1 và có ít nhất 2 sinh viên đăng ký học?
SELECT MH.TENMH
FROM MONHOC MH
INNER JOIN DIEM D ON MH.MAMH = D.MAMH
WHERE MH.SOTC > 1
GROUP BY MH.MAMH, MH.TENMH
HAVING COUNT(D.MASV) >= 2;