    /* Học phần: Cơ sở dữ liệu
       Người thực hiện: Nguyễn Trần Quang Bảo
       MSSV: 1911133
       Ngày: 04/03/2021
    */	

----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab01_QLNV -- lenh khai bao CSDL
go
--lenh su dung CSDL
use Lab01_QLNV
go
--lenh tao cac bang
create table ChiNhanh(
MSCN	char(2) primary key,		 --khai bao MSCN la khoa chinh cua ChiNhanh
TenCN	nvarchar(30) not null unique --khai bao TenCN không được để trống và không được nhập trùng
)
go
create table KyNang(
MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN)--khai báo MSCN là khóa ngoại của bảng NhanVien
)
go
create table NhanVienKyNang(
	MANV CHAR (4) REFERENCES NhanVien(MANV),
	MSKN CHAR (2) REFERENCES KyNang(MSKN),
	MucDo TINYINT check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=1)
	PRIMARY KEY (MANV,MSKN)--Khai báo NhanVienKyNang có khóa chính gồm 2 thuộc tính (MaNV, MSKN))

-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
INSERT INTO ChiNhanh VALUES ('01',N'Quận 1')
INSERT INTO ChiNhanh VALUES ('02',N'Quận 5')
INSERT INTO ChiNhanh VALUES ('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)

select * from NhanVienKyNang
----------------------------------------------------------------------
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------

-- Câu 1
-- a) Hiển thị MSNV
SELECT MANV,Ho+''+Ten AS HoTen,YEAR(GETDATE())-YEAR(NgayVaoLam) AS SoNamCT
FROM dbo.NhanVien

--b)
SELECT Ho+''+Ten AS HoTen,Ngaysinh,NgayVaoLam,TenCN
FROM dbo.NhanVien A, dbo.ChiNhanh B
ORDER BY TenCN

--c)
SELECT ho+''+ten AS hoten,c.TenKN,b.MucDo
FROM dbo.NhanVien a,dbo.NhanVienKyNang b,dbo.KyNang c
WHERE a.MANV=b.MANV AND b.MSKN=c.MSKN AND c.TenKN='Word'

--d)
SELECT b.TenKN,c.MucDo
FROM dbo.NhanVien a,dbo.KyNang b,dbo.NhanVienKyNang c
WHERE a.MANV=c.MANV AND c.MSKN=b.MSKN AND ho=N'Lê Anh' AND ten=N'Tuấn'

--câu 3
--a)
SELECT a.TenCN,count(b.MANV)AS SoNV 
FROM dbo.ChiNhanh a,dbo.NhanVien b
WHERE a.MSCN=b.MSCN
GROUP BY TenCN

--b)
SELECT a.TenKN,COUNT(b.MANV)AS SoNguoiDung
FROM dbo.KyNang a,dbo.NhanVienKyNang b
WHERE a.MSKN=b.MSKN
GROUP BY a.TenKN

--c)
SELECT a.TenKN,COUNT(b.MANV)AS SoNguoiDung
FROM dbo.KyNang a,dbo.NhanVienKyNang b
WHERE a.MSKN=b.MSKN
GROUP BY a.TenKN
HAVING COUNT(b.MANV)>=3

----------------------------------------------------------------------
--------------------TRUY VẤN LỒNG---------------
--a)
SELECT a.MANV,Ho+N''+Ten AS HoTen,b.MSCN,b.TenCN
FROM dbo.NhanVien a,dbo.ChiNhanh b,dbo.KyNang c,dbo.NhanVienKyNang d
WHERE a.MANV=d.MANV AND a.MSCN=b.MSCN AND c.MSKN=d.MSKN AND c.TenKN='Excel'
	AND d.MucDo = (SELECT MAX(MucDo)
				   FROM dbo.NhanVienKyNang e , dbo.KyNang f
				   WHERE e.MSKN=f.MSKN AND f.TenKN='Excel')
					
--b)
SELECT a.MANV,Ho+N''+Ten AS HoTen,d.TenCN
FROM dbo.NhanVien a,dbo.KyNang c,dbo.NhanVienKyNang b,dbo.ChiNhanh d
WHERE a.MANV=b.MANV AND b.MSKN=c.MSKN AND a.MSCN=d.MSCN and TenKN = 'Word'
	AND a.MANV IN (SELECT e.MANV
				   FROM dbo.NhanVienKyNang e , dbo.KyNang f
				   WHERE e.MSKN=f.MSKN AND TenKN='Excel')

--c)
SELECT a.MANV,Ho+N''+Ten AS HoTen,d.TenCN,c.TenKN,b.MucDo
FROM dbo.NhanVien a,dbo.KyNang c,dbo.NhanVienKyNang b,dbo.ChiNhanh d
WHERE a.MANV=b.MANV AND b.MSKN=c.MSKN AND a.MSCN=d.MSCN
	AND b.MucDo = (SELECT MAX(e.MucDo)
				   FROM dbo.NhanVienKyNang e
				   WHERE e.MSKN=b.MSKN )

--d)
SELECT b.MSCN,b.TenCN
FROM dbo.NhanVien a,dbo.ChiNhanh b,dbo.KyNang c,dbo.NhanVienKyNang d
WHERE a.MANV=d.MANV AND a.MSCN=b.MSCN AND c.MSKN=d.MSKN AND tenkn='Word'
	AND EXISTS (SELECT *
				   FROM dbo.NhanVienKyNang e , dbo.KyNang f
				   WHERE e.MSKN=c.MSKN AND f.TenKN='Word' AND e.MANV=a.MANV AND e.MSKN=c.MSKN)
				   GROUP BY b.MSCN,b.TenCN

--3d)
SELECT A.MSCN, TenCN
FROM dbo.NhanVien A, dbo.ChiNhanh B
WHERE a.MSCN = b.MSCN
GROUP BY A.MSCN, TenCN
HAVING COUNT(MANV) >=ALL(SELECT COUNT(MANV)
							FROM dbo.NhanVien
							GROUP BY MSCN)

--3e)
SELECT A.MSCN, TenCN
FROM dbo.NhanVien A, dbo.ChiNhanh B
WHERE a.MSCN = b.MSCN
GROUP BY A.MSCN, TenCN
HAVING COUNT(MANV) <= ALL(SELECT COUNT(MANV)
							FROM dbo.NhanVien
							GROUP BY MSCN)
