/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Trần Quang Bảo
   MSSV: 1911133
   Ngày: 04/03/2021
*/	

CREATE DATABASE Lab05_QLTDL
GO

USE Lab05_QLTDL
GO	

CREATE TABLE Tour(
MaTour CHAR(4),
tongSoNgay INT CHECK(tongSoNgay > 0)
PRIMARY KEY(MaTour)
)
GO

CREATE TABLE ThanhPho(
MaTP CHAR(2),
TenTP NVARCHAR(30) UNIQUE,
PRIMARY KEY (MaTP)
)
GO	

CREATE TABLE Tour_TP(
MaTour CHAR(4) REFERENCES dbo.Tour(MaTour),
MaTP CHAR(2) REFERENCES dbo.ThanhPho(MaTP),
SoNgay INT CHECK(soNgay > 0),
PRIMARY KEY (MaTour, MaTP, SoNgay)
)
GO	

CREATE TABLE LichTour(
MaTour CHAR(4) REFERENCES dbo.Tour(MaTour),
NgayKH DATETIME,
TenHDV NVARCHAR(30),
SoNguoi INT CHECK (soNguoi > 0),
TenKH NVARCHAR(30),
PRIMARY KEY (MaTour, NgayKH)
)
GO

INSERT INTO Tour VALUES ('T001', 3)
INSERT INTO Tour VALUES ('T002', 4)
INSERT INTO Tour VALUES ('T003', 5)
INSERT INTO Tour VALUES ('T004', 7)
GO

INSERT INTO ThanhPho VALUES ('01', N'Đà Lạt')
INSERT INTO ThanhPho VALUES ('02', N'Nha Trang')
INSERT INTO ThanhPho VALUES ('03', N'Phan Thiết')
INSERT INTO ThanhPho VALUES ('04', N'Huế')
INSERT INTO ThanhPho VALUES ('05', N'Đà Nẵng')
GO

INSERT INTO Tour_TP VALUES ('T001', '01', 2)
INSERT INTO Tour_TP VALUES ('T001', '03', 1)
INSERT INTO Tour_TP VALUES ('T002', '01', 2)
INSERT INTO Tour_TP VALUES ('T002', '02', 2)
INSERT INTO Tour_TP VALUES ('T003', '02', 2)
INSERT INTO Tour_TP VALUES ('T003', '01', 1)
INSERT INTO Tour_TP VALUES ('T003', '04', 2)
INSERT INTO Tour_TP VALUES ('T004', '02', 2)
INSERT INTO Tour_TP VALUES ('T004', '05', 2)
INSERT INTO Tour_TP VALUES ('T004', '04', 3)
GO

SET DATEFORMAT dmy;
INSERT INTO LichTour VALUES ('T001', '14/02/2017', N'Vân', 20, N'Nguyễn Hoàng')
INSERT INTO LichTour VALUES ('T002', '14/02/2017', N'Nam', 30, N'Lê Ngọc')
INSERT INTO LichTour VALUES ('T002', '06/03/2017', N'Hùng', 20, N'Lý Dũng')
INSERT INTO LichTour VALUES ('T003', '18/02/2017', N'Dũng', 20, N'Lý Dũng')
INSERT INTO LichTour VALUES ('T004', '18/02/2017', N'Hùng', 30, N'Dũng Nam')
INSERT INTO LichTour VALUES ('T003', '10/03/2017', N'Nam', 45, N'Nguyễn An')
INSERT INTO LichTour VALUES ('T002', '28/04/2017', N'Vân', 25, N'Ngọc Dung')
INSERT INTO LichTour VALUES ('T004', '29/04/2017', N'Dũng', 35, N'Lê Ngọc')
INSERT INTO LichTour VALUES ('T001', '30/04/2017', N'Nam', 25, N'Trần Nam')
INSERT INTO LichTour VALUES ('T003', '15/06/2017', N'Vân', 20, N'Trịnh Bá')
GO

SELECT * FROM Tour
SELECT * FROM ThanhPho
SELECT * FROM Tour_TP
SELECT * FROM LichTour

