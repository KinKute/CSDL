/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Trần Quang Bảo
   MSSV: 1911133
   Ngày: 04/03/2021
*/	

CREATE DATABASE Lab03_QLHH
GO
USE Lab03_QLHH
GO

CREATE TABLE HangHoa(
	MaHH VARCHAR(5) PRIMARY KEY,
	TenHH VARCHAR(30),
	DVT NVARCHAR(3),
	SoLuongTon INT
)

INSERT INTO HangHoa VALUES ('CPU01', 'CPU INTEL,CELERON 600 BOX', 'CÁI', 5)
INSERT INTO HangHoa VALUES ('CPU02', 'CPU INTEL,PIII 700', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('CPU03', 'CPU AMD K7 ATHL,ON 600', 'CÁI', 8)
INSERT INTO HangHoa VALUES ('HDD01', 'HDD 10.2 GB QUANTUM', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('HDD02', 'HDD 13.6 GB SEAGATE', 'CÁI', 15)
INSERT INTO HangHoa VALUES ('HDD03', 'HDD 20 GB QUANTUM', 'CÁI', 6)
INSERT INTO HangHoa VALUES ('KB01', 'KB GENIUS', 'CÁI', 12)
INSERT INTO HangHoa VALUES ('KB02', 'KB MITSUMIMI', 'CÁI', 5)
INSERT INTO HangHoa VALUES ('MB01', 'GIGABYTE CHIPSET INTEL', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('MB02', 'ACOPR BX CHIPSET VIA', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('MB03', 'INTEL PHI CHIPSET INTEL', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('MB04', 'ECS CHIPSET SIS', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('MB05', 'ECS CHIPSET VIA', 'CÁI', 10)
INSERT INTO HangHoa VALUES ('MNT01', 'SAMSUNG 14" SYNCMASTER', 'CÁI', 5)
INSERT INTO HangHoa VALUES ('MNT02', 'LG 14"', 'CÁI', 5)
INSERT INTO HangHoa VALUES ('MNT03', 'ACER 14"', 'CÁI', 8)
INSERT INTO HangHoa VALUES ('MNT04', 'PHILIPS 14"', 'CÁI', 6)
INSERT INTO HangHoa VALUES ('MNT05', 'VIEWSONIC 14"', 'CÁI', 7)

CREATE TABLE DoiTac(
	MaDT VARCHAR(5)	PRIMARY KEY,
	TenDT NVARCHAR(25),
	DiaChi NVARCHAR(40),
	DienThoai CHAR(10))

INSERT INTO DoiTac VALUES ('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
INSERT INTO DoiTac VALUES ('CC002', N'Cty Hoàng Long', N'15A TTT Q1 – TP. HCM', '08.8250898')
INSERT INTO DoiTac VALUES ('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 – TP.HCM', '08.8252376')
INSERT INTO DoiTac VALUES ('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp. Đà Lạt', '063.831129')
INSERT INTO DoiTac VALUES ('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ. N.Trang', '058.590270')
INSERT INTO DoiTac VALUES ('K0003', N'Trần nhật Duật', N'Lê Lợi TP. Huế', '054.848376');
INSERT INTO DoiTac VALUES ('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi nghĩa- TP. Đà lạt', '063.823409')

CREATE TABLE HoaDon(
	SoHD VARCHAR(5) PRIMARY KEY,
	NgayLapHD DATETIME,
	MaDT VARCHAR(5)REFERENCES dbo.DoiTac(MaDT),
	TongTG FLOAT)

SET DATEFORMAT dmy;
INSERT INTO HoaDon VALUES('N0001', '25/01/2006', 'CC001',null)
INSERT INTO HoaDon VALUES('N0002', '01/05/2006', 'CC002',null)
INSERT INTO HoaDon VALUES('X0001', '12/05/2006', 'K0001',null)
INSERT INTO HoaDon VALUES('X0002', '16/06/2006', 'K0002',null)
INSERT INTO HoaDon VALUES('X0003', '20/04/2006', 'K0001',null)

CREATE TABLE KhaNangCC(
	MaDT VARCHAR(5)REFERENCES dbo.DoiTac(MaDT),
	MaHH VARCHAR(5)REFERENCES dbo.HangHoa(MaHH))

INSERT INTO KhaNangCC VALUES ('CC001', 'CPU01')
INSERT INTO KhaNangCC VALUES ('CC001', 'HDD03')
INSERT INTO KhaNangCC VALUES ('CC001', 'KB01')
INSERT INTO KhaNangCC VALUES ('CC001', 'MB02')
INSERT INTO KhaNangCC VALUES ('CC001', 'MB04')
INSERT INTO KhaNangCC VALUES ('CC001', 'MNT01')
INSERT INTO KhaNangCC VALUES ('CC002', 'CPU01');
INSERT INTO KhaNangCC VALUES ('CC002', 'CPU02');
INSERT INTO KhaNangCC VALUES ('CC002', 'CPU03');
INSERT INTO KhaNangCC VALUES ('CC002', 'KB02');
INSERT INTO KhaNangCC VALUES ('CC002', 'MB01');
INSERT INTO KhaNangCC VALUES ('CC002', 'MB05');
INSERT INTO KhaNangCC VALUES ('CC002', 'MNT03');
INSERT INTO KhaNangCC VALUES ('CC003', 'HDD01');
INSERT INTO KhaNangCC VALUES ('CC003', 'HDD02');
INSERT INTO KhaNangCC VALUES ('CC003', 'HDD03');
INSERT INTO KhaNangCC VALUES ('CC003', 'MB03');

CREATE TABLE CT_HoaDon(
	SoHD VARCHAR(5)REFERENCES dbo.HoaDon(SoHD),
	MaHH VARCHAR(5)REFERENCES dbo.HangHoa(MaHH),
	DonGia INT,
	SoLuong int)

INSERT INTO CT_HoaDon VALUES ('N0001', 'CPU01', 63, 10);
INSERT INTO CT_HoaDon VALUES ('N0001', 'HDD03', 97, 7);
INSERT INTO CT_HoaDon VALUES ('N0001', 'KB01', 3, 5);
INSERT INTO CT_HoaDon VALUES ('N0001', 'MB02', 57, 5);
INSERT INTO CT_HoaDon VALUES ('N0001', 'MNT01', 112, 3);
INSERT INTO CT_HoaDon VALUES ('N0002', 'CPU02', 115, 3);
INSERT INTO CT_HoaDon VALUES ('N0002', 'KB02', 5, 7);
INSERT INTO CT_HoaDon VALUES ('N0002', 'MNT03', 111, 5);
INSERT INTO CT_HoaDon VALUES ('X0001', 'CPU01', 67, 2);
INSERT INTO CT_HoaDon VALUES ('X0001', 'HDD03', 100, 2);
INSERT INTO CT_HoaDon VALUES ('X0001', 'KB01', 5, 2);
INSERT INTO CT_HoaDon VALUES ('X0001', 'MB02', 62, 1);
INSERT INTO CT_HoaDon VALUES ('X0002', 'CPU01', 67, 1);
INSERT INTO CT_HoaDon VALUES ('X0002', 'KB02', 7, 3);
INSERT INTO CT_HoaDon VALUES ('X0002', 'MNT01', 115, 2);
INSERT INTO CT_HoaDon VALUES ('X0003', 'CPU01', 67, 1);
INSERT INTO CT_HoaDon VALUES ('X0003', 'MNT03', 115, 2)

SELECT * FROM HangHoa
SELECT * FROM DoiTac;
SELECT * FROM CT_HoaDon
SELECT * FROM KhaNangCC;
SELECT * FROM HoaDon;

----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------
--1) Liệt kê các mặt hàng thộc loại đĩa cứng

SELECT*
FROM dbo.HangHoa
WHERE MaHH LIKE'HDD%'

--2) Liệt kê các mặt hàng có số lượng tồn trên 10

SELECT  MaHH AS N'Mã hàng hóa',TenHH AS N'Tên hàng hóa',SoLuongTon AS N'Số lượng tồn'
FROM dbo.HangHoa
WHERE SoLuongTon>10

--3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh

SELECT MaDT AS N'Mã đối tác', TenDT AS N'Tên đối tác',DiaChi AS N'Địa chỉ',DienThoai AS N'Điện thoại'
FROM dbo.DoiTac
WHERE DiaChi LIKE '%HCM'

/*4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gôm: sohd, 
ngaylaphd, tên, địa chỉ và điện thoại nhà cung cấp, số mặt hàng */

SELECT c.SoHD AS N'Số hóa đơn',b.NgayLapHD AS N'Ngày lập hóa đơn',a.TenDT AS N'Tên đối tác',
a.DiaChi AS N'Địa chỉ',a.DienThoai AS N'Điện thoại',SUM(c.SoLuong) AS N'Số lượng'
FROM dbo.DoiTac a,dbo.HoaDon b,dbo.CT_HoaDon c
WHERE b.SoHD=c.SoHD AND a.MaDT=b.MaDT AND MONTH(b.NgayLapHD)='05'
GROUP BY c.SoHD,NgayLapHD,a.TenDT,a.DiaChi,a.DienThoai

--5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.

SELECT a.MaHH, b.TenDT, b.DiaChi, b.DienThoai
FROM dbo.KhaNangCC a,dbo.DoiTac b
WHERE a.MaDT=b.MaDT AND a.MaHH LIKE 'HDD%'

--6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.

SELECT b.TenDT, b.DiaChi, b.DienThoai, COUNT(a.MaHH) AS SoLuong
FROM dbo.KhaNangCC a, dbo.DoiTac b
WHERE a.MaDT = b.MaDT AND a.MaHH LIKE 'HDD%'
GROUP BY b.MaDT,TenDT, DiaChi, DienThoai
HAVING COUNT(a.MaHH) = (SELECT COUNT(MaHH)
					  FROM dbo.HangHoa
					  WHERE MaHH LIKE 'HDD%')

--7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.

SELECT b.MaDT, b.TenDT, b.DiaChi, b.DienThoai
FROM dbo.KhaNangCC a, dbo.DoiTac b
WHERE a.MaDT = b.MaDT 
GROUP BY b.MaDT, b.TenDT, b.DiaChi, b.DienThoai
HAVING b.MaDT NOT IN (SELECT e.MaDT
					  FROM dbo.KhaNangCC e, dbo.DoiTac f
					  WHERE e.MaDT = f.MaDT AND MaHH LIKE'HDD%'
					  GROUP BY e.MaDT)
					  
--8) Cho biết thông tin của mặt hàng chưa bán được

SELECT a.MaHH AS N'Mã hàng hóa',a.TenHH AS N'Tên hàng hóa',SoLuongTon AS N'Số lượng tồn'
FROM dbo.HangHoa a,dbo.HoaDon b,dbo.CT_HoaDon c
WHERE b.SoHD=c.SoHD 
GROUP BY a.MaHH,a.TenHH,SoLuongTon
HAVING a.MaHH NOT IN (SELECT e.MaHH
					FROM dbo.HangHoa d,dbo.CT_HoaDon e
					WHERE d.MaHH=e.MaHH
					GROUP BY e.MaHH)

--9) Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng)

SELECT  a.MaHH AS N'Mã hàng hóa', TenHH AS N'Tên hàng hóa',SUM(c.SoLuong)AS N'Số lượng'
FROM dbo.HangHoa a, dbo.HoaDon b,dbo.CT_HoaDon c
WHERE a.MaHH=c.MaHH AND b.SoHD=c.SoHD 
GROUP BY a.MaHH, TenHH
HAVING COUNT(c.SoLuong)>=ALL(SELECT COUNT(SoLuong)
						FROM dbo.CT_HoaDon
						GROUP BY MaHH)

--10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất

SELECT MaHH AS N'Mã hàng hóa', TenHH AS N'Tên hàng hóa',DVT AS N'Đơn vị tính',SoLuongTon AS N'Số lượng tồn'
FROM dbo.HangHoa
WHERE SoLuongTon<=ALL(SELECT SoLuongTon FROM dbo.HangHoa)

--11) Cho biết hóa đơn nhập nhiều mặt hàng nhiều nhất

SELECT a.TenHH,a.MaHH, COUNT(SoHD) AS N'Số lần nhập',SUM(SoLuong)AS N'Tổng số lượng'
FROM dbo.HangHoa a, dbo.CT_HoaDon b
WHERE a.MaHH=b.MaHH 
GROUP BY a.TenHH,a.MaHH
HAVING COUNT(SoHD)>=ALL
	(SELECT COUNT(SoHD)
     FROM dbo.CT_HoaDon 
	 GROUP BY MaHH
	)

--12) Cho biết các mặt hàng không được nhập trong tháng 1/2006

SELECT a.MaHH, a.TenHH, a.DVT, a.SoLuongTon, b.NgayLapHD
FROM dbo.HangHoa a, dbo.HoaDon b, dbo.CT_HoaDon c
WHERE a.MaHH = c.MaHH AND b.SoHD = c.SoHD AND a.MaHH NOT IN 
(
	SELECT b.MaHH
	FROM dbo.HoaDon a, dbo.CT_HoaDon b
	WHERE a.SoHD = b.SoHD AND MONTH(a.NgayLapHD) = 1 AND YEAR(a.NgayLapHD) = 2006
	
)

-- 13) Cho biết tên các mặt hàng không bán được trong tháng 6/2006

SELECT MaHH, TenHH, DVT, SoLuongTon
FROM dbo.HangHoa
WHERE MaHH NOT IN 
(
	SELECT b.MaHH
	FROM dbo.HoaDon a, dbo.CT_HoaDon b
    WHERE a.SoHD = b.SoHD AND a.SoHD LIKE 'X%' AND MONTH(a.NgayLapHD) = 6 AND YEAR(a.NgayLapHD) = 2006
)

-- 14) Cho biết cửa hàng bán bao nhiêu mặt hàng

SELECT COUNT(TenHH) AS N'Số lượng mặt hàng'
FROM dbo.HangHoa

-- 15) Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp.
SELECT b.MaDT, b.TenDT, b.DiaChi, b.DienThoai, COUNT(a.MaHH) AS N'Số lượng mặt hàng'
FROM dbo.KhaNangCC a, dbo.DoiTac b
WHERE a.MaDT = b.MaDT
GROUP BY b.MaDT, b.TenDT, b.DiaChi, b.DienThoai

-- 16) Cho biết thông tin của khách hàng có giao dịch với của hàng nhiều nhất.

SELECT b.MaDT, b.TenDT, b.DiaChi, b.DienThoai, COUNT(a.SoHD) AS N'Số lần giao dịch'
FROM dbo.HoaDon a, dbo.DoiTac b, dbo.CT_HoaDon c
WHERE a.MaDT = b.MaDT AND a.SoHD = c.SoHD AND b.MaDT LIKE 'K%'
GROUP BY b.MaDT, b.TenDT, b.DiaChi, b.DienThoai
HAVING COUNT(a.SoHD)>=ALL
(
	SELECT COUNT(d.MaDT)
	FROM dbo.HoaDon d, dbo.CT_HoaDon e
	WHERE d.SoHD = e.SoHD AND d.MaDT LIKE 'K%'
	GROUP BY d.MaDT
)

-- 17) Tính tổng doanh thu năm 2006

SELECT SUM(b.DonGia * b.SoLuong) AS ThanhTien
FROM dbo.HoaDon a, dbo.CT_HoaDon b
WHERE a.SoHD = b.SoHD AND YEAR(a.NgayLapHD) = 2006 AND a.SoHD LIKE 'x%'

-- 18) Cho biết mặt hàng bán chạy nhất

SELECT a.MaHH, a.TenHH, SUM(c.SoLuong) AS SoLuongBan
FROM dbo.HangHoa a, dbo.HoaDon b, dbo.CT_HoaDon c
WHERE a.MaHH = c.MaHH AND b.SoHD LIKE 'X%'
GROUP BY a.MaHH, a.TenHH
HAVING SUM(c.SoLuong) >=ALL
(
	SELECT SUM(SoLuong)	
	FROM dbo.HoaDon d, dbo.CT_HoaDon e
	WHERE d.SoHD LIKE 'x%' AND d.SoHD = e.SoHD
	GROUP BY e.MaHH
)

-- 19) Liệt kê thông tin bán hàng của tháng 5/2016 gồm: MaHH, TenHH, DVT, TongSL, TongThanhTien

SELECT b.MaHH, b.TenHH, b.DVT, SUM(c.SoLuong) AS TongSoLuong, SUM(c.DonGia * c.SoLuong) AS TongThanhTien
FROM dbo.HoaDon a, dbo.HangHoa b, dbo.CT_HoaDon c
WHERE c.SoHD = a.SoHD AND b.MaHH = c.MaHH AND MONTH(a.NgayLapHD) = 5 AND YEAR(a.NgayLapHD) = 2006
GROUP BY b.MaHH, b.TenHH, b.DVT

-- 20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất

SELECT a.MaHH, a.TenHH, SUM(c.SoLuong) AS SoLuongBan
FROM dbo.HangHoa a, dbo.HoaDon b, dbo.CT_HoaDon c
WHERE b.SoHD = c.SoHD AND a.MaHH = c.MaHH AND b.SoHD LIKE 'X%'
GROUP BY a.MaHH, a.TenHH
HAVING SUM(c.SoLuong)>=ALL
(
	SELECT SUM(e.SoLuong)
	FROM dbo.HoaDon d, dbo.CT_HoaDon e
	WHERE d.SoHD = e.SoHD AND d.SoHD LIKE 'X%'
	GROUP BY e.SoHD
)	