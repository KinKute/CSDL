/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Trần Quang Bảo
   MSSV: 1911133
   Ngày: 04/03/2021
*/	

CREATE DATABASE Lab04_QLDB
GO

USE Lab04_QLDB
GO

CREATE TABLE KhachHang(
MaKH CHAR (5),
TenKH NVARCHAR(10) NOT NULL,
DiaChi NVARCHAR(10)
PRIMARY KEY (MaKH)
)
GO

CREATE TABLE BAO_TCHI(
MaBaoTC CHAR(5),
Ten NVARCHAR(30),
DinhKy NVARCHAR(20),
SoLuong INT,
GiaBban INTEGER,
PRIMARY KEY(MaBaoTC)
)
GO

CREATE TABLE PHATHANH(
MaBaoTC CHAR(5)REFERENCES dbo.BAO_TCHI(MaBaoTC),
SoBaoTC INT,
NgayPH DATETIME,
PRIMARY KEY(MaBaoTC,SoBaoTC)
)
GO

CREATE TABLE DATBAO(
MaKH CHAR(5) REFERENCES dbo.KhachHang(MaKH),
MaBaoTC CHAR(5) REFERENCES dbo.BAO_TCHI(MaBaoTC),
SLMua INT,
NgayDM DATETIME
PRIMARY KEY(MaKH,MaBaoTC)
)
GO

INSERT INTO KhachHang VALUES ('KH01',N'LAN',N'2 NCT')
INSERT INTO KhachHang VALUES ('KH02',N'NAM',N'32 THĐ')
INSERT INTO KhachHang VALUES ('KH03',N'NGỌC',N'16 LHP')
GO

INSERT INTO BAO_TCHI VALUES ('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
INSERT INTO BAO_TCHI VALUES ('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
INSERT INTO BAO_TCHI VALUES ('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
INSERT INTO BAO_TCHI VALUES ('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
INSERT INTO BAO_TCHI VALUES ('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)
GO

SET DATEFORMAT DMY
INSERT INTO PHATHANH VALUES ('TT01',123,'15/12/2005')
INSERT INTO PHATHANH VALUES ('KT01',70,'15/12/2005')
INSERT INTO PHATHANH VALUES ('TT01',124,'16/12/2005')
INSERT INTO PHATHANH VALUES ('TN01',256,'17/12/2005')
INSERT INTO PHATHANH VALUES ('PN01',45,'23/12/2005')
INSERT INTO PHATHANH VALUES ('PN02',111,'18/12/2005')
INSERT INTO PHATHANH VALUES ('PN02',112,'19/12/2005')
INSERT INTO PHATHANH VALUES ('TT01',125,'17/12/2005')
INSERT INTO PHATHANH VALUES ('PN01',46,'30/12/2005')
GO

SET DATEFORMAT DMY
INSERT INTO DATBAO VALUES ('KH01','TT01',100,'12/01/2000')
INSERT INTO DATBAO VALUES ('KH02','TN01',150,'01/05/2001')
INSERT INTO DATBAO VALUES ('KH01','PN01',200,'25/06/2001')
INSERT INTO DATBAO VALUES ('KH03','KT01',50,'17/03/2002')
INSERT INTO DATBAO VALUES ('KH03','PN02',200,'26/08/2003')
INSERT INTO DATBAO VALUES ('KH02','TT01',250,'15/01/2004')
INSERT INTO DATBAO VALUES ('KH01','KT01',300,'14/10/2004')
GO

SELECT * FROM dbo.KhachHang
SELECT * FROM dbo. BAO_TCHI
SELECT * FROM dbo.DATBAO
SELECT * FROM dbo.PHATHANH

----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------
--1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (tuần báo)s

SELECT MaBaoTC AS MaBao,Ten,GiaBban
FROM dbo.BAO_TCHI
WHERE DinhKy=N'Tuần báo'

--2)

SELECT *
FROM dbo.BAO_TCHI
WHERE MaBaoTC LIKE 'PN%'

--3)

SELECT *
FROM dbo.BAO_TCHI a,dbo.KhachHang b,dbo.DATBAO c
WHERE a.MaBaoTC=c.MaBaoTC AND b.MaKH=c.MaKH AND a.MaBaoTC like 'PN%'


--4) Cho biết các khách hàng có đặt mua tất cả các báo phụ nữ

SELECT a.MaKH, a.TenKH, a.DiaChi
FROM dbo.KhachHang a, dbo.DATBAO b
WHERE a.MaKH = b.MaKH AND b.MaBaoTC LIKE'PN%'
GROUP BY a.MaKH, a.TenKH, a.DiaChi
HAVING COUNT(b.MaBaoTC) = 
(
	SELECT COUNT(c.MaBaoTC)
	FROM dbo.BAO_TCHI c
	WHERE c.MaBaoTC LIKE 'PN%'
)

--5) Cho biết các khách hàng không đặt mua báo thanh niên

SELECT b.MaBaoTC,c.TenKH,c.DiaChi
FROM dbo.BAO_TCHI a,dbo.DATBAO b,dbo.KhachHang c
WHERE a.MaBaoTC=b.MaBaoTC AND b.MaKH=c.MaKH
GROUP BY b.MaBaoTC,c.TenKH,c.DiaChi
HAVING b.MaBaoTC NOT IN (SELECT e.MaBaoTC FROM dbo.DATBAO d,dbo.BAO_TCHI e WHERE d.MaBaoTC=e.MaBaoTC AND e.MaBaoTC LIKE'TN%' 
GROUP BY e.MaBaoTC)

--6) Cho biết số tờ báo mà mối khách hàng đã đặt mua

SELECT a.TenKH, a.DiaChi, b.MaBaoTC, b.Ten, sum(c.SLMua) AS SoLuongMua
FROM dbo.KhachHang a, dbo.BAO_TCHI b, dbo.DATBAO c
WHERE a.MaKH = c.MaKH AND b.MaBaoTC = c.MaBaoTC 
GROUP BY a.TenKH, a.DiaChi, b.MaBaoTC, b.Ten

-- 7) Cho biết số khách hàng đặt mua báo trong năm 2004

SELECT a.TenKH, a.DiaChi, b.NgayDM
FROM dbo.KhachHang a, dbo.DATBAO b
WHERE a.MaKH = b.MaKH AND YEAR(b.NgayDM) = 2004

-- 8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, Ten, DinhKy, SLMua, SoTien)
-- trong đó SoTien = SLMua x DonGia

SELECT a.TenKH, c.Ten, c.DinhKy, SUM(b.SLMua) AS SoLuongMua, SUM(b.SLMua * c.GiaBban) AS SoTien
FROM dbo.KhachHang a, dbo.DATBAO b, dbo.BAO_TCHI c
WHERE b.MaBaoTC = c.MaBaoTC AND c.MaBaoTC = b.MaBaoTC
GROUP BY a.MaKH, a.TenKH, a.DiaChi, c.MaBaoTC, c.Ten, c.DinhKy

--9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng
-- đối với báo - tạp chí đó

SELECT a.Ten, a.DinhKy, SUM(a.SoLuong) AS SoLuong
FROM dbo.BAO_TCHI a, dbo.DATBAO b
WHERE a.MaBaoTC = b.MaBaoTC
GROUP BY a.Ten, a.DinhKy

-- 10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS)

SELECT *
FROM dbo.BAO_TCHI
WHERE Ten LIKE '%HS%'

-- 11) Cho biết những tờ báo không có người đặt mua

SELECT a.MaBaoTC
FROM dbo.DATBAO a
WHERE a.MaBaoTC NOT IN 
(
	SELECT b.MaBaoTC
	FROM dbo.BAO_TCHI b
)

-- 12) Cho biết tên, định kỳ của tờ bóa có nhiều người mua nhất

SELECT a.Ten, a.DinhKy, SUM(b.SLMua)AS SoLuongMua
FROM dbo.BAO_TCHI a, dbo.DATBAO b
WHERE a.MaBaoTC = b.MaBaoTC
GROUP BY a.Ten, a.DinhKy
HAVING SUM(b.SLMua)>=all
(
	SELECT  SUM(c.SLMua)
	FROM dbo.DATBAO c
	GROUP BY MaBaoTC
)

-- 13) Cho biết khách hàng đặt mua nhiều báo - tạp chí nhất

SELECT a.TenKH, a.DiaChi, SUM(c.SLMua) AS SoLuong
FROM dbo.KhachHang a, dbo.BAO_TCHI b, dbo.DATBAO c
WHERE a.MaKH =c.MaKH AND b.MaBaoTC = c.MaBaoTC
GROUP BY a.TenKH, a.DiaChi
HAVING SUM(c.SLMua) >= ALL
(
	SELECT SUM(SLMua)
	FROM dbo.DATBAO 
    GROUP BY MaKH
)

-- 14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần

SELECT DinhKy, COUNT(DinhKy)
FROM dbo.BAO_TCHI 
GROUP BY DinhKy
HAVING COUNT(DinhKy)>=2

-- 15) Cho biết các tờ báo, tạp chí có từ 3 khách đặt mua trở lên

SELECT b.MaBaoTC, c.Ten, c.DinhKy, COUNT(a.MaKH) AS SLKhachMua
FROM dbo.KhachHang a, dbo.DATBAO b, dbo.BAO_TCHI c
where b.MaBaoTC = c.MaBaoTC
GROUP BY b.MaBaoTC, c.Ten, c.DinhKy
HAVING COUNT(a.MaKH) >= 3;