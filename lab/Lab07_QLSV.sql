/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Trần Quang Bảo
   MSSV: 1911133
   Ngày: 04/03/2021
*/	

CREATE DATABASE Lab07_QLSV
GO

USE Lab07_QLSV
GO

CREATE TABLE KHOA
(
MSKhoa int PRIMARY KEY,
TenKhoa NVARCHAR(30),
TenTat VARCHAR(5)
)

INSERT INTO KHOA VALUES (01,N'Công nghệ thông tin','CNTT')
INSERT INTO KHOA VALUES (02,N'Điện Tử viễn thông','DTVT')
INSERT INTO KHOA VALUES (03,N'Quản trị kinh doanh','QTKD')
INSERT INTO KHOA VALUES (04,N'Công nghệ sinh học','CNSH')


CREATE TABLE LOP
(
MSLop VARCHAR(5) PRIMARY KEY,
TenLop VARCHAR(30),
MSKhoa INT REFERENCES dbo.KHOA(MSKhoa),
NienKhoa INT CHECK (NienKhoa>0)
)

INSERT INTO LOP VALUES('98TH','Tin hoc khoa 1998',01,1998)
INSERT INTO LOP VALUES('98VT','Vien Thong khoa 1998',02,1998)
INSERT INTO LOP VALUES('99TH','Tin hoc khoa 1999',01,1999)
INSERT INTO LOP VALUES('99VT','Vien thong khoa 1999',02,1999)
INSERT INTO LOP VALUES('99QT','Quan tri khoa 1999',03,1999)

CREATE TABLE TINH
(
MSTinh INT PRIMARY KEY,
TenTinh VARCHAR(10),
)

INSERT INTO TINH VALUES (01,'An Giang')
INSERT INTO TINH VALUES (02,'TPHCM')
INSERT INTO TINH VALUES (03,'DONG NAI')
INSERT INTO TINH VALUES (04,'LONG AN')
INSERT INTO TINH VALUES (05,'HUE')
INSERT INTO TINH VALUES (06,'CA MAU')

CREATE TABLE MONHOC
(
MSMH VARCHAR(5) PRIMARY KEY,
TenMH VARCHAR(25),
HeSo INT NOT NULL,
)

INSERT INTO MONHOC VALUES ('TA01','Nhap mon tin hoc',2)
INSERT INTO MONHOC VALUES ('TA02','Lap trinh co ban',3)
INSERT INTO MONHOC VALUES ('TB01','Cau truc du lieu',2)
INSERT INTO MONHOC VALUES ('TB02','Co so du lieu',2)
INSERT INTO MONHOC VALUES ('QA01','Kinh te vi mo',2)
INSERT INTO MONHOC VALUES ('QA02','Quan tri chat luong',3)
INSERT INTO MONHOC VALUES ('VA01','Dien tu co ban',2)
INSERT INTO MONHOC VALUES ('VA02','Mach so',3)
INSERT INTO MONHOC VALUES ('VB01','Truyen so lieu',3)
INSERT INTO MONHOC VALUES ('XA01','Vat ly dai cuong',2)

CREATE TABLE SINHVIEN
(
MSSV VARCHAR(10) PRIMARY KEY,
Ho VARCHAR(15),
Ten VARCHAR(10),
NgaySinh DATETIME,
MSTinh INT REFERENCES dbo.TINH(MSTinh),
NgayNhapHoc DATETIME,
MSLop VARCHAR(5) REFERENCES dbo.LOP(MSLop),
Phai VARCHAR(3),
DiaChi VARCHAR(30),
DienThoai INT CHECK (DienThoai>0),
)
SET DATEFORMAT DMY
INSERT INTO SINHVIEN VALUES ('98TH001', 'Nguyen Van',  'An',   '06/08/80', 01, '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1',	8234512)
INSERT INTO SINHVIEN VALUES ('98TH002', 'Le Thi',	   'An',	  '17/10/79', 01, '03/09/98', '98TH', 'No',  '23 CMT8, Q. Tan Binh',	0303234342)
INSERT INTO SINHVIEN VALUES ('98VT001', 'Nguyen Duc',  'Binh', '25/11/81', 02, '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', 8654323)
INSERT INTO SINHVIEN VALUES ('98VT002', 'Tran Ngoc',   'Anh', '19/08/80', 02, '03/09/98', '98VT', 'No',  '242 Tran Hung Dao, Q.1' ,NULL)
INSERT INTO SINHVIEN VALUES ('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', 03, '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', 7563213)
INSERT INTO SINHVIEN VALUES ('99TH002', 'Van Minh', 'Hoang', '01/01/81', 04, '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', 8341234)
INSERT INTO SINHVIEN VALUES ('99TH003', 'Nguyen', 'Tuan', '12/01/80', 03, '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5',NULL)
INSERT INTO SINHVIEN VALUES ('99TH004', 'Tran Van', 'Minh', '25/06/81', 04, '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', 7236754)
INSERT INTO SINHVIEN VALUES ('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', 04, '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL)
INSERT INTO SINHVIEN VALUES ('99VT001', 'Le Ngoc', 'Mai', '21/06/82', 01, '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', 0903124534)
INSERT INTO SINHVIEN VALUES ('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', 04, '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', 0901656324)
INSERT INTO SINHVIEN VALUES ('99QT002', 'Le My', 'Hanh', '20/05/76', 04, '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL)

CREATE TABLE BANGDIEM 
(
MSSV VARCHAR(10)FOREIGN KEY REFERENCES dbo.SINHVIEN(MSSV),
MSMH VARCHAR(5)FOREIGN KEY REFERENCES dbo.MONHOC(MSMH),
LanThi TINYINT NOT NULL,
Diem FLOAT NOT NULL
PRIMARY KEY (MSSV,MSMH,LanThi)
)

INSERT INTO BANGDIEM VALUES ('98TH001', 'TA01', 1, 8.5)
INSERT INTO BANGDIEM VALUES ('98TH001', 'TA02', 1, 8)
INSERT INTO BANGDIEM VALUES ('98TH002', 'TA01', 1, 4)
INSERT INTO BANGDIEM VALUES ('98TH002', 'TA01',2,5.5)
INSERT INTO BANGDIEM VALUES ('98TH001', 'TB01',1,7.5)
INSERT INTO BANGDIEM VALUES ('98TH002', 'TB01' ,1, 8)
INSERT INTO BANGDIEM VALUES ('98VT001', 'VA01', 1, 4)
INSERT INTO BANGDIEM VALUES ('98VT001', 'VA01' ,2, 5)
INSERT INTO BANGDIEM VALUES ('98VT002', 'VA02', 1, 7.5)
INSERT INTO BANGDIEM VALUES ('99TH001', 'TA01', 1, 4)
INSERT INTO BANGDIEM VALUES ('99TH001', 'TA01', 2, 6)
INSERT INTO BANGDIEM VALUES ('99TH001', 'TB01', 1, 6.5)
INSERT INTO	BANGDIEM VALUES ('99TH002', 'TB01', 1, 10)
INSERT INTO BANGDIEM VALUES ('99TH002', 'TB02', 1, 9)
INSERT INTO BANGDIEM VALUES ('99TH003', 'TA02', 1, 7.5)
INSERT INTO BANGDIEM VALUES ('99TH003', 'TB01', 1, 3)
INSERT INTO BANGDIEM VALUES ('99TH003', 'TB01', 2, 6)
INSERT INTO BANGDIEM VALUES ('99TH003', 'TB02', 1, 8)
INSERT INTO	BANGDIEM VALUES ('99TH004', 'TB02', 1, 2)
INSERT INTO BANGDIEM VALUES ('99TH004', 'TB02', 2, 4)
INSERT INTO BANGDIEM VALUES ('99TH004', 'TB02', 3, 3)
INSERT INTO BANGDIEM VALUES ('99QT001', 'QA01', 1, 7)
INSERT INTO BANGDIEM VALUES ('99QT001', 'QA02', 1, 6.5)
INSERT INTO BANGDIEM VALUES ('99QT002', 'QA01', 1, 8.5)
INSERT INTO BANGDIEM VALUES ('99QT002', 'QA02', 1, 9)

SELECT*FROM dbo.SINHVIEN
SELECT*FROM dbo.BANGDIEM
SELECT*FROM dbo.KHOA
SELECT*FROM dbo.LOP
SELECT*FROM dbo.MONHOC
SELECT*FROM	dbo.TINH

----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------

-- Câu 1: Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả các sinh viên

SELECT MSSV,Ho AS N'Họ',Ten AS N'Tên',DiaChi AS N'Địa chỉ'
FROM dbo.SINHVIEN

-- Câu 2:Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MS
-- tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên. 

SELECT MSSV,Ho AS N'Họ',Ten AS N'Tên',MSTinh AS N'MS Tỉnh'
FROM dbo.SINHVIEN 
ORDER BY MSTinh, Ten

-- Câu 3: Liệt kê các sinh viên nữ của tỉnh Long An

SELECT *
FROM dbo.SINHVIEN
WHERE Phai='No'

-- Câu 4: Liệt kê các sinh viên có sinh nhật trong tháng giêng.

SELECT *
FROM dbo.SINHVIEN
WHERE MONTH(NgaySinh)=1

-- Câu 5: Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1.

SELECT*
FROM dbo.SINHVIEN
WHERE MONTH(NgaySinh) LIKE '%1' AND NgaySinh LIKE '%1'

-- Câu 6: Liệt kê các sinh viên có số điện thoại.

SELECT *
FROM dbo.SINHVIEN
WHERE DienThoai is NOT NULL

-- Câu 7: Liệt kê các sinh viên có số điện thoại di động.

SELECT *
FROM dbo.SINHVIEN
WHERE DienThoai is NOT NULL

-- Câu 8: Liệt kê các sinh viên tên ‘Minh’ học lớp ’99TH’

SELECT *
FROM dbo.SINHVIEN
WHERE Ten='Minh' AND MSLop='99TH'

-- Câu 9: Liệt kê các sinh viên có địa chỉ ở đường ‘Tran Hung Dao’

SELECT*
FROM dbo.SINHVIEN
WHERE DiaChi LIKE '%Tran Hung Dao%'

-- Câu 10 Liệt kê các sinh viên có tên lót chữ ‘Van’ (không liệt kê người họ ‘Van’)

SELECT*
FROM dbo.SINHVIEN
WHERE Ho LIKE '%Van'

-- Câu 11: Liệt kê MSSV, Họ Ten (ghép họ và tên thành một cột), Tuổi của các sinh viên ở tỉnh Long An.

SELECT MSSV,Ho+' '+Ten AS N'Họ Tên',DATEDIFF(YEAR, NgaySinh, GETDATE()) AS N'Tuổi',b.TenTinh AS N'Tỉnh'
FROM dbo.SINHVIEN a,dbo.TINH b
WHERE a.MSTinh=b.MSTinh and b.TenTinh LIKE '%Long An%'

-- Câu 12: Liệt kê các sinh viên nữ từ 23 đến 28 tuổi.

SELECT MSSV,Ho,Ten,DATEDIFF(YEAR, NgaySinh, NgayNhapHoc) AS N'Tuổi',Phai,DiaChi,DienThoai
FROM dbo.SINHVIEN
WHERE Phai='No' AND DATEDIFF(YEAR, NgaySinh, NgayNhapHoc)<=28 AND 23<=DATEDIFF(YEAR, NgaySinh, NgayNhapHoc)

-- Câu 13: Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên.

SELECT MSSV, Ho + '' + Ten AS HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi
FROM dbo.SINHVIEN
WHERE Phai = 'yes' AND YEAR(GETDATE()) - YEAR(NgaySinh) >= 32
	  OR 
	  (
		phai = 'no' AND YEAR(GETDATE()) - YEAR(NgaySinh) >= 27
	  )

-- Câu 14: Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi.

SELECT MSSV,Ho,Ten,DATEDIFF(YEAR, NgaySinh, NgayNhapHoc) AS N'Tuổi',Phai,DiaChi,DienThoai
FROM dbo.SINHVIEN
WHERE DATEDIFF(YEAR, NgaySinh, NgayNhapHoc)<18 OR DATEDIFF(YEAR, NgaySinh, NgayNhapHoc)>=25

-- Câu 15: Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là ‘99’).

SELECT*
FROM dbo.SINHVIEN
WHERE MSSV LIKE'99%'

-- Câu 16: Liệt kê MSSV, Điểm thi lần 1 môn ‘Co so du lieu’ của lớp ’99TH’

SELECT *
FROM dbo.SINHVIEN a,dbo.MONHOC b,dbo.BANGDIEM c
WHERE a.MSSV=c.MSSV AND b.MSMH=c.MSMH AND b.TenMH='Co so du lieu' AND c.LanThi=1 AND a.MSLop='99TH'

-- Câu 17 Liệt kê MSSV, Họ tên của các sinh viên lớp ’99TH’ thi không đạt lần 1 môn ‘Co so du lieu’

SELECT*
FROM dbo.SINHVIEN a,dbo.MONHOC b,dbo.BANGDIEM c
WHERE a.MSSV=c.MSSV AND b.MSMH=c.MSMH AND b.TenMH='Co so du lieu' AND Diem<5

-- Câu 18: Liệt kê tất cả các điểm thi của sinh viên có mã số ’99TH001’

SELECT c.MSMH,c.TenMH AS N'Tên MH',b.LanThi AS N'Lần thi',b.Diem AS N'Điểm'
FROM dbo.SINHVIEN a,dbo.BANGDIEM b,dbo.MONHOC c
WHERE a.MSSV=b.MSSV AND b.MSMH=c.MSMH AND a.MSSV='99TH001' 

-- Câu 19: Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn ‘Co so du lieu’ từ 8 điểm trở lên

SELECT a.MSSV,c.Ho AS N'Họ',c.ten AS N'Tên',c.MSLop
FROM dbo.BANGDIEM a,dbo.MONHOC b,dbo.SINHVIEN c
WHERE a.MSSV=c.MSSV AND a.MSMH=b.MSMH AND b.TenMH LIKE'Co so%' AND a.Diem>=8 AND a.LanThi=1

-- Câu 20: Liệt kê các tỉnh không có sinh viên theo học

SELECT *
FROM dbo.TINH d
WHERE NOT EXISTS (SELECT *
					FROM dbo.SINHVIEN a
					WHERE a.MSTinh=d.MSTinh)

-- Câu 21: Liệt kê các sinh viên hiện chưa có điểm môn thi nào.

SELECT *
FROM dbo.SINHVIEN s
WHERE NOT EXISTS (SELECT *
					FROM dbo.BANGDIEM b
					WHERE s.MSSV = b.MSSV)

----------------------------------------------------------------------
--------------------TRUY VAN GOM NHOM---------------

-- Câu 22: Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV

SELECT b.MSLop, TenLop,COUNT(MSSV) AS N'Số lượng sv'
FROM dbo.SINHVIEN a,dbo.LOP b
WHERE a.MSLop=b.MSLop
GROUP BY b.MSLop, TenLop

-- Câu 23: Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu 
-- MSTinh Tên Tỉnh Số SV Nam Số SV Nữ Tổng cộng

CREATE FUNCTION UF_PhaiNam(@tinh CHAR(2))
RETURNS INT
	AS
		BEGIN
			DECLARE @soPhai INT
			SELECT @soPhai = COUNT(a.Phai)
			FROM dbo.SINHVIEN a, dbo.TINH b
			WHERE a.Phai='Yes' AND b.MSTinh = @tinh AND b.MSTinh = a.MSTinh
			RETURN @soPhai
		END
CREATE FUNCTION UF_PhaiNu(@tinh CHAR (2))
RETURNS int
	AS
		BEGIN
			DECLARE @soPhai INT
			SELECT @soPhai = COUNT(a.Phai)
			FROM dbo.SINHVIEN a,dbo.TINH b
            WHERE a.Phai = 'No' AND b.MSTinh = @tinh AND b.MSTinh = a.MSTinh
            RETURN @soPhai
		END
SELECT dbo.UF_PhaiNam('01') AS N'Phái Nam'
-- Câu 24: Thống kê kết quả thi lần 1 môn ‘Co so du lieu’ ở các lớp, theo mẫu sau
-- MSLop TenLop Số SV đạt Tỉ lệ đạt (%) Số SV không đạt Tỉ lệ không đạt


-- Câu 25: Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của
-- mỗi môn là điểm cao nhất trong các lần thi của môn đó)
-- MSSV MSMH Tên MH Hệ số Điểm Điểm x hệ số

SELECT a.MSSV, b.MSMH, b.TenMH, b.HeSo, MAX(a.Diem) AS Diem
FROM dbo.BANGDIEM a, dbo.MONHOC b
WHERE a.MSMH = b.MSMH
GROUP BY a.MSSV, b.MSMH, b.TenMH, b.HeSo

-- Câu 26: Lập bảng tổng kết theo mẫu sau: MSSV - Họ Tên - ĐTB
-- Trong đó: Điểm trung bình (ĐTB) = Tổng (điểm x hệ số)/Tổng hệ số

SELECT b.MSSV, Ho + ' ' + Ten AS HoTen, c.TenMH, MAX(a.Diem) AS Diem
FROM dbo.BANGDIEM a, dbo.SINHVIEN b, dbo.MONHOC c
WHERE b.MSSV = c.MSMH AND a.
-- Câu 27 Thống kê số lượng sinh viên tỉnh ‘Long An’ đang theo học ở các khoa, theo mẫu sau:
-- Năm học MSKhoa TenKhoa Số lượng SV

SELECT c.MSKhoa,TenKhoa,COUNT(MSSV) AS N'Số lượng SV'
FROM dbo.SINHVIEN a,dbo.TINH b,dbo.KHOA c,dbo.LOP d
WHERE a.MSTinh=b.MSTinh AND b.TenTinh='Long An' AND a.MSLop=d.MSLop AND c.MSKhoa=d.MSKhoa
GROUP BY  c.MSKhoa,TenKhoa

----------------------------------------------------------------------
--------------------HAM VA THU TUC---------------

-- Câu 28: Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm
-- cao nhất trong các lần thi):
-- MSMH Tên MH Hệ số Điểm


-- Câu 29: Nhập vào MS lớp, in ra bảng tổng kết của lớp đó, theo mẫu sau:
-- MSSV Họ Tên ĐTB Xếp loại


----------------------------------------------------------------------
--------------------CAP NHAT DU LIEU---------------
-- 30) Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên (lấy từ table SinhVien)
-- có quê quán không phải ở TPHCM. Thêm thuộc tính HBONG (học bổng) cho table
-- SinhVienTinh.

CREATE TABLE SinhVienTinh
(
	MSSV CHAR(7) PRIMARY KEY,
	Ho VARCHAR(50),
	Ten VARCHAR(30),
	NgaySinh DATE,
	MSTinh INT REFERENCES dbo.TINH(MSTinh),
	NgayNhapHoc DATE,
	MSLop VARCHAR(5) REFERENCES dbo.LOP(MSLop),
	Phai VARCHAR(5),
	DiaChi VARCHAR(100),
	DienThoai VARCHAR(13),
	HocBong INT
)
SET DATEFORMAT dmy;
INSERT INTO SinhVienTinh VALUES ('98TH001', 'Nguyen Van',  'An',   '06/08/80', 01, '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1',	8234512, NULL)
INSERT INTO SinhVienTinh VALUES ('98TH002', 'Le Thi',	   'An',	  '17/10/79', 01, '03/09/98', '98TH', 'No',  '23 CMT8, Q. Tan Binh',	0303234342, NULL)
INSERT INTO SinhVienTinh VALUES ('98VT001', 'Nguyen Duc',  'Binh', '25/11/81', 02, '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', 8654323, NULL)
INSERT INTO SinhVienTinh VALUES ('98VT002', 'Tran Ngoc',   'Anh', '19/08/80', 02, '03/09/98', '98VT', 'No',  '242 Tran Hung Dao, Q.1' ,NULL, NULL)
INSERT INTO SinhVienTinh VALUES ('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', 03, '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', 7563213, NULL)
INSERT INTO SinhVienTinh VALUES ('99TH002', 'Van Minh', 'Hoang', '01/01/81', 04, '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', 8341234, NULL)
INSERT INTO SinhVienTinh VALUES ('99TH003', 'Nguyen', 'Tuan', '12/01/80', 03, '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5',NULL, NULL)
INSERT INTO SinhVienTinh VALUES ('99TH004', 'Tran Van', 'Minh', '25/06/81', 04, '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', 7236754, NULL)
INSERT INTO SinhVienTinh VALUES ('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', 04, '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL, NULL)
INSERT INTO SinhVienTinh VALUES ('99VT001', 'Le Ngoc', 'Mai', '21/06/82', 01, '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', 0903124534, NULL)
INSERT INTO SinhVienTinh VALUES ('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', 04, '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', 0901656324, NULL)
INSERT INTO SinhVienTinh VALUES ('99QT002', 'Le My', 'Hanh', '20/05/76', 04, '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL, NULL)

-- Câu 31: Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên.

UPDATE dbo.SinhVienTinh
SET HocBong = 10000
SELECT * FROM dbo.SinhVienTinh

-- Câu 32: Tăng HBONG lên 10% cho các sinh viên nữ.

UPDATE dbo.SinhVienTinh
SET HocBong =  HocBong * 1.1
WHERE Phai = 'No'

-- Câu 33: Xóa tất cả các sinh viên có quê quán ở Long An ra khỏi table SinhVienTinh.

DELETE 
FROM  dbo.SinhVienTinh
WHERE MSTinh = 
(
	SELECT MSTinh
	FROM dbo.TINH
	WHERE Ten = 'Long An'
)

SELECT * FROM dbo.SinhVienTinh