CREATE DATABASE Lab06_QLHV
GO
USE Lab06_QLHV
GO

CREATE TABLE CaHoc
(Ca TINYINT PRIMARY KEY,
GioBatDau TIME,
GioKetThuc TIME)
GO
SELECT * FROM dbo.CaHoc
INSERT dbo.CaHoc
(
    Ca,
    GioBatDau,
    GioKetThuc
)
VALUES
(   2,          -- Ca - tinyint
    '7:30', -- GioBatDau - time
    '6:45'  -- GioKetThuc - time
    )

CREATE TABLE GiaoVien
(MSGV CHAR(4) PRIMARY KEY,
HoGV NVARCHAR(20)NOT NULL,
TenGV NVARCHAR(10) NOT NULL,
DienThoai VARCHAR(6))
GO

CREATE TABLE Lop
(MaLop CHAR(4) PRIMARY KEY,
TenLop VARCHAR(15) NOT NULL,
NgayKG DATETIME,
HocPhi INT CHECK(HocPhi>0),
Ca TINYINT REFERENCES dbo.CaHoc(Ca),
SoTiet TINYINT,
SoHV TINYINT CHECK(SoHV<=30),
MSGV CHAR(4) REFERENCES dbo.GiaoVien(MSGV)
)
GO

CREATE TABLE HocVien
(
MSHV CHAR(10) PRIMARY KEY,
Ho NVARCHAR(20),
Ten NVARCHAR(10),
NgaySinh DATETIME,
Phai CHAR(3),
MaLop CHAR(4) REFERENCES dbo.Lop(MaLop))
GO

CREATE TABLE HocPhi
(SoBL CHAR(4) PRIMARY KEY,
MSHV CHAR(10) REFERENCES dbo.HocVien(MSHV),
NgayThu DATETIME,
SoTien INT,
NoiDung VARCHAR(20),
NguoiThu NVARCHAR(10) NOT NULL)
GO



CREATE TRIGGER RangBuoc_SiSo
ON dbo.CaHoc
FOR	INSERT
AS
BEGIN
	DECLARE @Count INT = 0;
	SELECT @Count=COUNT(*)FROM Inserted
	WHERE DATEPART(HOUR,Inserted.GioBatDau)-DATEPART(HOUR,Inserted.GioKetThuc)>0

	IF(@Count>0)
	BEGIN
		PRINT N'Giờ không chính xác'
		ROLLBACK TRAN
		END
END


CREATE TRIGGER RangBuocLop
ON dbo.Lop
FOR	INSERT
AS
BEGIN
	DECLARE @Count INT = 0;
	SELECT @Count=COUNT(*)FROM Inserted
	WHERE Inserted.SoHV<=30 AND Inserted.SoHV=(SELECT COUNT(MaLop)
												FROM dbo.HocVien
												WHERE MaLop=Inserted.MaLop)

	IF(@Count>0)
	BEGIN
		PRINT N'Sĩ số của một lớp học không quá 30 họ viên và đúng bằng số học viên'
		ROLLBACK TRAN
		END
END

CREATE TRIGGER RangBuocTien
ON dbo.HocPhi
FOR	INSERT
AS
BEGIN
	DECLARE @Count INT = 0;
	SELECT @Count=COUNT(*)FROM Inserted
	WHERE Inserted.SoTien<=(SELECT HocPhi
							FROM dbo.Lop,dbo.HocVien
							WHERE MSHV=Inserted.MSHV)

	IF(@Count>0)
	BEGIN
		PRINT N'Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học'
		ROLLBACK TRAN
		END
END
