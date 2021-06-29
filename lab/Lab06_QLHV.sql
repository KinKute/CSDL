/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Trần Quang Bảo
   MSSV: 1911133
   Ngày: 04/03/2021
*/	

CREATE DATABASE Lab06_QLHV
GO

USE Lab06_QLHV
GO

CREATE TABLE CaHoc(
	Ca TINYINT PRIMARY KEY,
	GioBatDau DATETIME,
	GioKetThuc DATETIME)

CREATE TABLE GiaoVien(
	MSGV CHAR(4)PRIMARY KEY,
	HoGV NVARCHAR(20),
	TenGV NVARCHAR(10),
	DienThoai VARCHAR(11))

CREATE TABLE Lop(
	MaLop CHAR(4) PRIMARY KEY,
	TenLop NVARCHAR(30),
	NgayKG DATETIME,
	HocPhi INT,
	Ca TINYINT REFERENCES dbo.CaHoc(Ca),
	SoTiet TINYINT,
	SoHV TINYINT,
	MSGV CHAR(4) REFERENCES dbo.GiaoVien(MSGV))

CREATE TABLE HocVien(
	MSHV VARCHAR(10) PRIMARY KEY,
	Ho NVARCHAR(30),
	Ten NVARCHAR(10),
	NgaySinh DATETIME,
	Phai NVARCHAR(3),
	MaLop CHAR(4) REFERENCES dbo.Lop(MaLop))

CREATE TABLE HocPhi(
	SoBL TINYINT PRIMARY KEY,
	MSHV VARCHAR(10) REFERENCES dbo.HocVien(MSHV),
	NgayThu DATETIME,
	SoTien INT,
	NoiDung VARCHAR(30),
	NguoiThu NVARCHAR(5))

---------- NHẬP DỮ LIỆU CHO CÁC BẢNG -------------

INSERT INTO CaHoc VALUES (1, '7:30', '10:45')
INSERT INTO CaHoc VALUES (2, '13:30', '16:45')
INSERT INTO CaHoc VALUES (3 ,'17:30','20:45')

INSERT INTO GiaoVien VALUES ('G001', N'Lê Hoàng', N'Anh', 858936)
INSERT INTO GiaoVien VALUES ('G002', N'Nguyễn Ngọc', N'Lan', 845623)
INSERT INTO GiaoVien VALUES ('G003', N'Trần Minh', N'Hùng', 823456)
INSERT INTO GiaoVien VALUES ('G004', N'Võ Thanh', N'Trung', 841256)

SET DATEFORMAT DMY
INSERT INTO Lop VALUES ('E114', 'Excel 3-5-7', '02/01/2008', 120000, 1, 45, 3, 'G003')
INSERT INTO Lop VALUES ('E115', 'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001')
INSERT INTO Lop VALUES ('W123', 'Word 2-4-6', '18/02/2008', 100000, 3, 30, 1, 'G001')
INSERT INTO Lop VALUES ('W124', 'Word 3-5-7', '01/03/2008', 100000, 1, 30, 0, 'G002')
INSERT INTO Lop VALUES ('A075', 'Access 2-4-6', '18/12/2008', 150000, 3, 60, 3, 'G003')

----------CÀI ĐẶT CÁC RÀNG BUỘC TOÀN VẸN -------------

-- 4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó
CREATE TRIGGER tr_CaHoc_ins_upd_GioBD_GioKT
ON CaHoc FOR INSERT, UPDATE
AS
IF UPDATE(GioBatDau) OR UPDATE(GioKetThuc)
	IF EXISTS (SELECT * FROM inserted i WHERE i.GioKetThuc < i.GioBatDau)
	BEGIN
		RAISERROR (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15, 1)
		ROLLBACK TRAN
	END
GO

-- 4b) Sĩ số (SoHV) của một lớp học không quá 30 học viên và đúng bằng số học viên thuộc lớp đó

CREATE TRIGGER trg_Lop_ins_upd
ON dbo.Lop FOR INSERT, UPDATE
AS
IF UPDATE(MaLop) OR UPDATE(SoHV)
BEGIN
	IF EXISTS (SELECT * FROM inserted i WHERE i.SoHV > 30)
	BEGIN
		RAISERROR (N'Số học viên của một lớp không quá 30', 15, 1)
		ROLLBACK TRAN
	END
    IF EXISTS (SELECT * FROM inserted l WHERE l.SoHV <> (SELECT COUNT(MSHV)
														 FROM HocVien
														 WHERE HocVien.MaLop = l.Malop))
	BEGIN
		RAISERROR (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó', 15, 1)
		ROLLBACK TRAN
	END
END
GO

-- 4c) Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học

CREATE TRIGGER trg_HocPhi
ON dbo.HocPhi FOR INSERT, UPDATE
AS
	IF UPDATE(SoTien)
	BEGIN
		IF EXISTS 
		(
			SELECT * 
			FROM dbo.Lop a, dbo.HocVien b, dbo.HocPhi c
			WHERE a.MaLop = b.MaLop AND b.MSHV = c.MSHV
			GROUP BY a.MaLop, a.HocPhi, b.MSHV, b.Ho, b.Ten
			HAVING SUM(c.SoTien)>a.HocPhi
		)
			PRINT N'Tổng tiền thu 1 học viên vượt quá học phí của lớp!'
	END
GO


----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU -------------

-- Câu 4a: Thêm dữ liệu vào các bảng
-- Bảng ca học

CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd datetime, @giokt datetime
AS
	IF EXISTS(SELECT*FROM dbo.CaHoc WHERE Ca=@ca)
			PRINT N'Đã có ca học'+@ca+N' trong CSDL'
	ELSE
			BEGIN
				INSERT INTO CaHoc VALUES(@ca,@giobd,@giokt)
				PRINT N'Thêm ca học thành công!'
			END
GO
     
EXEC usp_ThemCaHoc 1,'7:30','10:45'
EXEC usp_ThemCaHoc 2,'13:30','16:45'
EXEC usp_ThemCaHoc 3,'17:30','20:45'

-- Bảng giáo viên

CREATE PROC usp_ThemGiaoVien
	@MSGV CHAR(4), @HoGV NVARCHAR, @TenGV NVARCHAR, @DienThoai VARCHAR
AS
	IF EXISTS(SELECT*FROM dbo.GiaoVien WHERE MSGV=@MSGV)
			PRINT N'Đã có giáo viên mã số '+@MSGV+ N' trong CLDS!'
	ELSE
			BEGIN
				INSERT INTO GiaoVien VALUES(@MSGV, @HoGV, @TenGV, @DienThoai)
				PRINT N'Thêm giáo viên mã số '+@MSGV+' thành công!'
			END
GO

EXEC usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh','858936'
EXEC usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan','845623'
EXEC usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng','823456'
EXEC usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung','841256'

-- Bảng lớp

CREATE PROC usp_Lop
	@MaLop CHAR(4),@TenLop NVARCHAR(30),@NgayKG DATETIME,@HocPhi INT,@Ca TINYINT,@SoTiet TINYINT,@SoHV TINYINT,@MSGV CHAR(4)
AS
	IF EXISTS(SELECT*FROM dbo.CaHoc WHERE Ca=@Ca)AND EXISTS(SELECT*FROM dbo.GiaoVien WHERE MSGV=@MSGV)
		BEGIN
			IF EXISTS(SELECT*FROM dbo.Lop WHERE MaLop=@MaLop)
			PRINT N'Đã có lớp mã số '+@MaLop+' trong CSDL!'
	ELSE
			BEGIN
				INSERT INTO Lop VALUES(@MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV)
				PRINT N'Thêm lớp có mã số '+@MaLop+N' vào CSDL!'
			END
		END
	ELSE 
		IF NOT EXISTS(SELECT*FROM dbo.CaHoc WHERE Ca=@Ca)
						PRINT N'Không có ca học ' +@Ca +N' trong CSDL'
		ELSE PRINT N'Không có giáo viên '+@MSGV+N' trong CSDL'
GO

SET DATEFORMAT DMY
EXEC usp_Lop 'E114',N'Excel 3-5-7','02/01/2008',120000,1,45,3,'G003'
EXEC usp_Lop 'E115',N'Excel 2-4-6','22/01/2008',120000,3,45,0,'G001'
EXEC usp_Lop 'W123',N'Word 2-4-6','18/02/2008',100000,3,30,0,'G001'
EXEC usp_Lop 'W124',N'Word 3-5-7','01/03/2008',100000,1,30,0,'G002'
EXEC usp_Lop 'A075',N'Access 2-4-6','18/12/2008',150000,3,60,3,'G003'

-- Bảng học viên

CREATE PROC usp_HocVien
	@MSHV VARCHAR(10), @Ho NVARCHAR(30), @Ten NVARCHAR(10), @NgaySinh DATETIME, @Phai NVARCHAR(3), @MaLop CHAR(4)
AS
	IF EXISTS(SELECT*FROM dbo.Lop WHERE MaLop=@MaLop)
		BEGIN
			IF EXISTS(SELECT*FROM dbo.HocVien WHERE MSHV=@MSHV)
			PRINT N'Đã có học viên mã số'+@MSHV+N' trong CSDL!'
	ELSE
			BEGIN
				INSERT INTO	HocVien VALUES (@MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop)
				PRINT N'Thêm học viên '+@MSHV+' thành công'
			END
		END
	ELSE
		PRINT N'Lớp '+@MaLop+N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'
GO

SET DATEFORMAT DMY
EXEC usp_HocVien 'A07501',N'Lê Văn',N'Minh','10/06/1998',N'Nam','A075'
EXEC usp_HocVien 'A07502',N'Nguyễn Thị',N'Mai','20/04/1998',N'Nữ','A075'
EXEC usp_HocVien 'A07503',N'Lê Ngọc',N'Tuấn','10/06/1994',N'Nam','A075'
EXEC usp_HocVien 'E11401',N'Vương Tuấn',N'Vũ','25/03/1999',N'Nam','E114'
EXEC usp_HocVien 'E11402',N'Lý Ngọc',N'Hân','01/12/1995',N'Nữ','E114'
EXEC usp_HocVien 'E11403',N'Trần Mai',N'Linh','04/06/1990',N'Nữ','E114'
EXEC usp_HocVien 'A07501',N'Nguyễn Ngọc',N'Tuyết','12/05/1996',N'Nữ','W123'

-- Bảng học phí

create PROC usp_ThemHocPhi
@SoBL char(6),
@MSHV char(4),
@NgayThu Datetime,
@SoTien	int,
@NoiDung nvarchar(50),
@NguoiThu nvarchar(30)
As
	If exists(select * from dbo.HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from dbo.HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
GO

SET DATEFORMAT DMY
EXEC usp_ThemHocPhi 0001,'E11401','02/01/2008',120000,N'HP Excel 3-5-7',N'Vân'
EXEC usp_ThemHocPhi 0002,'E11402','02/01/2008',120000,N'HP Excel 3-5-7',N'Vân'
EXEC usp_ThemHocPhi 0003,'E11403','02/01/2008',80000, N'HP Excel 3-5-7',N'Vân'
EXEC usp_ThemHocPhi 0004,'W12301','18/02/2008',100000,N'HP Word 2-4-6',N'Lan'
EXEC usp_ThemHocPhi 0005,'A07501','16/12/2008',150000,N'HP Access 2-4-6',N'Lan'
EXEC usp_ThemHocPhi 0006,'A07502','16/12/2008',100000,N'HP Access 2-4-6',N'Lan'
EXEC usp_ThemHocPhi 0007,'A07503','18/12/2008',150000,N'HP Access 2-4-6',N'Vân'
EXEC usp_ThemHocPhi 0008,'A07502','02/01/2008',50000,N'HP Access 2-4-6',N'Vân'

-- 5a) Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp đó
CREATE FUNCTION fn_TongHocPhiLop(@MaLop CHAR(4)) RETURNS int
AS
BEGIN
	DECLARE @TongTien INT
	IF EXISTS
	(
		SELECT * 
		FROM dbo.Lop 
		WHERE MaLop = @MaLop
	)
		BEGIN
			SELECT @TongTien
			FROM dbo.HocPhi a, dbo.HocVien b
			WHERE a.MSHV = b.MSHV AND b.MaLop = @MaLop
		END
RETURN @TongTien
END
--------------------------------
PRINT dbo.fn_TongHocPhiLop('A075')

-- 5b) Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước

CREATE FUNCTION fn_TongHocPhi (@bd datetime, @kt datetime) RETURNS int
AS
BEGIN
	DECLARE @TongTien INT
	SELECT @TongTien = SUM(SoTien)
	FROM dbo.HocPhi
	WHERE NgayThu BETWEEN @bd AND @kt
RETURN @TongTien
END
----------------------------
PRINT dbo.fn_TongHocPhi('1/1/2008','15/1/2008')