Create database Lab02_QLSX_2
Go
Use Lab02_QLSX_2
Go
--//////////////////////////////////////////////
--///////////////////////YÊU CẦU////////////////
--//////////////////////////////////////////////

--Yêu cầu I
----1) Tạo các table và thiết lập mói quan hệ giữa các table. 
--Dựa vào dữ liệu mẫu, sinh viên tự chọn kiểu dữ liệu phù hợp cho các field của các bảng
--2) Cài đặt các ràng buộc toàn vẹn
--a) Tên Tổ sản xuất phải phân biệt(Không được giống nhau)
--b) Tên sản phẩm phải khác nhau
--c) Tiền công >0
--d) Số lượng phải là số nguyên dương
-- Có RBTV theo yêu cầu:

Create table ToSanXuat
(
MaTSX char(4) primary key,
TenTSX nvarchar(10) unique
)

Create table CongNhan
(
MACN char(5) primary key,
Ho nvarchar(20),
Ten nvarchar(10) not null,
Phai nvarchar(3) check(Phai = N'Nam' or Phai = N'Nữ'),
NgaySinh DATE,
MaTsx char(4) references ToSanXuat(MaTSX)
)

Create table SanPham
(
MaSP char(5) primary key,
TenSP nvarchar(20) unique,
DVT nvarchar(10) not null,
TienCong int check(TienCong>0)
)

Create table ThanhPham
(
MACN char(5) references CongNhan(MACN),
MaSP char(5) references SanPham(MaSP),
Ngay Date,
SoLuong int check(soluong >0),
primary key(MaCN,MaSP,Ngay)
)

select * from CongNhan
Select*from SanPham
Select * from ToSanXuat
Select * from ThanhPham
------ Delete
Drop table ThanhPham
Drop table SanPham
Drop table CongNhan
Drop table ToSanXuat

--3) Nhập dữ liệu vào bảng

--Tổ Sản Xuất
Insert into ToSanXuat values('TS01', N'Tổ 1')
Insert into ToSanXuat values('TS02', N'Tổ 2')

--	Công nhân
set dateformat dmy
Insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','12/05/1981','TS01')
Insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
Insert into CongNhan values ('CN003',N'Nguyễn Công',N'Thành',N'Nam','04/05/1981','TS02')
Insert into CongNhan values ('CN004',N'Võ Hữu',N'Hạnh',N'Nữ','15/02/1980','TS02')
Insert into CongNhan values ('CN005',N'Lý Thanh',N'Hân',N'Nữ','3/12/1981','TS01')

--	Sản phẩm
Insert into SanPham values('SP001',N'Nồi đất',N'cái',10000)
Insert into SanPham values('SP002',N'Chén',N'cái',2000)
Insert into SanPham values('SP003',N'Bình gốm nhỏ',N'cái',20000)
Insert into SanPham values('SP004',N'Bình gốm lớn',N'cái',25000)

-- Thành phẩm
Insert into ThanhPham values('CN001','SP001','01/02/2007',10)
Insert into ThanhPham values('CN002','SP001','01/02/2007',5)
Insert into ThanhPham values('CN003','SP002','10/01/2007',50)
Insert into ThanhPham values('CN004','SP003','12/01/2007',10)
Insert into ThanhPham values('CN005','SP002','12/01/2007',100)
Insert into ThanhPham values('CN002','SP004','13/02/2007',10)
Insert into ThanhPham values('CN001','SP003','14/02/2007',15)
Insert into ThanhPham values('CN003','SP001','15/01/2007',20)
Insert into ThanhPham values('CN003','SP004','14/02/2007',15)
Insert into ThanhPham values('CN004','SP002','30/01/2007',100)
Insert into ThanhPham values('CN005','SP003','01/02/2007',50)
Insert into ThanhPham values('CN001','SP001','20/02/2007',30)

--II. Tạo các Query
--1) Liệt kê công nhân theo tổ sản xuất gồm các thông tin: TenTSX, Hoten, NgaySinh,Phai 
--(xếp thứ tự dăng dần tên tổ sản xuất, tên công nhân)
Select TenTSX, Ho+' '+Ten, NgaySinh, Phai
From CongNhan A, ToSanXuat B
Where A.MaTsx=B.MaTSX
order by TenTSX, Ten

--2) Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được
--bao gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien (Xep theo ngày tăng dần).
Select TenSP, Ngay, SoLuong, SoLuong*TienCong as ThanhTien
From SanPham A,ThanhPham B, CongNhan C
Where A.MaSP=B.MaSP and B.MACN=C.MACN and Ho+ ' '+Ten = N'Nguyễn Trường An'
order by B.Ngay

--3) Liệt kê nhân viên không sản xuất 'bình gốm lớn'

Select A.MACN, Ho+' '+Ten as HoTen
From CongNhan A
Where A.MACN not in (Select B.MACN
					From CongNhan B, SanPham C, ThanhPham D
					Where B.MACN=D.MACN and C.MaSP=D.MaSP and C.TenSP = N'Bình gốm lớn')

--4)Liệt kê thông tin các nhân viên có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'

Select DISTINCT  D.MACN, Ho+' '+TEN as HoTen,Phai, NgaySinh, MaTsx
	From CongNhan D, SanPham E, ThanhPham F
	Where D.MACN=F.MACN and E.MaSP=F.MaSP and E.TenSP = N'Nồi đất' AND D.MACN 
	IN(Select A.MACN
	From CongNhan A,SanPham B, ThanhPham C
	Where A.MACN=C.MACN and B.MaSP=c.MaSP and B.TenSP = N'Bình gốm nhỏ')

--5)Thống kê số lượng công nhân theo từng tổ sản xuất
Select A.MaTSX, TenTSX, COUNT(A.MaTsx) as SoLuong
From CongNhan A, ToSanXuat B
Where A.MaTsx = B.MaTSX
group by A.MaTsx,TenTSX

--6) Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho,Ten,TenSP,TongSLThanhPham,TongThanhTien)
Select Ho, Ten,TenSP, SUM(SoLuong), Sum(SoLuong*TienCong) as TongThanhTien
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN = C.MaCN and B.MaSP=C.MaSP
Group by A.MACN, HO, TEN, TenSP

--7)Tong tien công đã trả cho công nhân trong tháng 01/2007
Select Sum(SoLuong*TienCong) as TongLuongTra
From SanPham A, ThanhPham B
Where A.MaSP=B.MASP and MONTH(Ngay)=1 and YEAR(Ngay)=2007

--8) Cho biết sản phẩm được sản xuất nhiều nhất trong thánh 2/2007
SeLect A.MaSP, TenSP, SUM(SoLuong) As TongSL
From SanPham A, ThanhPham B
Where A.MaSP=B.MaSP and MONTH(Ngay)=2 and YEAR(Ngay)=2007
group by A.MaSP, TenSP
Having Sum(SoLuong) >= ALL (Select SUM(SoLuong) as TongSL
							From SanPham C, ThanhPham D
							Where C.MaSP = D.MaSP and MONTH(Ngay)=2 and YEAR(Ngay)=2007
							Group by D.MaSP)

--9) Cho biết công nhân sản xuất được nhiều chén nhất
Select A.MACN,Ho, ten, Phai, NgaySinh, MaTsx, Sum(SoLuong) as TongSL
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN=C.MACN and B.MaSP=C.MaSP and C.MaSP='SP002'
Group by A.MACN, Ho, Ten, Phai, NgaySinh, MaTsx -- 50,100,100
Having SUM(SoLuong) >= ALL (Select SUM(SoLuong) as TongSL
							From CongNhan D, SanPham E, ThanhPham F
							Where D.MACN=F.MACN and E.MaSP=F.MaSP and F.MaSP='SP002'
							Group by D.MACN) --50,100,100

--10) Tính tiền công tháng 2/2007 của công nhân có mã số 'CN002'
Select  C.MACN, HO, Ten, Sum(TienCong*SoLuong) as Luong_02_2007
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN=C.MACN and B.MaSP=C.MaSP and C.MACN='CN002' and MONTH(Ngay)=2 and YEAR(Ngay)=2007
group by C.MACN, Ho, Ten

--11) Liệt kê công nhân có sản xuất 3 loại sản phẩm trở lên
Select A.MACN, Ho, Ten, COUNT(Distinct C.MaSP) as SoSP
From CongNhan A, SanPham B, ThanhPham C
Where A.MACN= C.MaCN and B.MaSP=C.MaSP
Group by A.MACN, Ho, Ten
Having Count(Distinct C.MaSP) >=3 

--12) Cập nhật giá tiền công của các loại bình gốm thêm 1000
Update SanPham
Set TienCong += 1000
Where TenSP like N'Bình gốm %'
Select * From SanPham

--13) Thêm bộ <'CN006','Lê Thị','Lan','Nữ','TS02'> vào bảng CongNhan
Insert into CongNhan values ('CN006',N'Lê Thị',N'Lan',N'Nữ','','TS02')

Alter table CongNhan add Constraint df_ngaysinh Default GetDATE() FOR ngaySinh
Select * From CongNhan

--////////////////////////////////////////////////////////////////
--/////////////////// HÀM VÀ THỦ TỤC /////////////////////////////

--////////////////////////////////////////////////////////////////
--/////////////////A. Viết các hàm ///////////////////////////////
--////////////////////////////////////////////////////////////////

--a. Tính tổng số công nhân của 1 tổ sản xuất cho trước:
Create Function ufn_TongCongNhan_TSX(@MaTSX char(4))
Returns int
As
	Begin 
		Declare @tongCN int
		Select @tongCN = COUNT(A.MATSX)
		From CongNhan A
		Where A.MaTSX=@MaTSX
		return @tongCN
	end

--VD:
print dbo.ufn_TongCongNhan_TSX('TS02')

--b. Tính tổng sản lượng sản xuất trong 1 tháng của 1 loại sản phẩm cho trước
--Drop function ufn_TongSanLuongSP_Month -- Xóa hàm
Create function ufn_TongSanLuongSP_Month(@thang int, @MaSP char(5))
returns int
AS
	Begin
		Declare @tongSL int
		Select @tongSL=SUM(B.SoLuong)
		From SanPham A, ThanhPham B
		Where A.MaSP=B.MaSP and MONTH(Ngay)=@thang and B.MaSP=@MaSP
		return @tongSL
	End

--VD: 
Print dbo.ufn_TongSanLuongSP_Month(2, 'SP001')

--c. Tính tổng tiền công tháng của 1 công nhân cho trước
Create function ufn_LuongThang(@maCN char(5), @thang int)
returns int 
AS
	Begin
		Declare @luong int
		Select @luong=SUM(SoLuong*TienCong)
		From CongNhan A, SanPham B, ThanhPham C
		Where A.MaCN=C.MaCN and B.MaSP=C.MaSP and MONTH(Ngay)=@thang and C.MaCN=@maCN
		return @luong
	END

--VD:
print dbo.ufn_LuongThang('CN001', 2)

--d. Tinh tong thu nhap trong nam của 1 tsx cho trước
Create function ufn_TongThuNhap_TSX(@tsx char(4), @nam int)
Returns int
As
	Begin
		Declare @tongThuNhap int
		Select @tongThuNhap=Sum(SoLuong*TienCong)
		From CongNhan A, SanPham B, ThanhPham C
		Where A.MaCN = C.MaCN and B.MaSP = C.MaSP and @tsx=A.MaTSX and YEAR(Ngay)=@nam
		return @tongThuNhap
	END

--VD:
print dbo.ufn_TongThuNhap_TSX('TS02', 2007)
select * from CongNhan
Select*from SanPham
Select * from ToSanXuat
Select * from ThanhPham

--E. Tính tổng sản lượng sản xuất của 1 loại sản phẩm trong khoảng thời gian cho trước
Drop function ufn_TongSL_DateTime
Create Function ufn_TongSL_DateTime(@Masp char(5), @Ngaybd DATE, @Ngaykt DATE)
returns int
AS
	Begin
		Declare @TongSL int
		Select @TongSL=SUM(SoLuong)
		From SanPham A, ThanhPham B
		Where A.MaSP=B.MaSP and @Ngaybd <= B.Ngay and B.Ngay <= @Ngaykt and @Masp=B.MaSP
		Return @TongSL
	END

--VD:
set DATE dmy
print dbo.ufn_TongSL_DateTime('SP002','10/01/2007','20/01/2007')
Select *From ThanhPham

--////////////////////////////////////////////////////////////////
--/////////////////A. Viết các thủ tục////////////////////////////
--////////////////////////////////////////////////////////////////

--a. In danh sách các công nhân của 1 tổ sản xuất cho trước.
Create proc usp_DanhSach_TSX @tsx char(4)
AS
		Select A.MaCN, Ho, Ten, Phai, NgaySinh
		From CongNhan A, ToSanXuat B
		where A.MaTSX = B.MaTSX and A.MaTSX = @tsx
Go
-----------------------------
exec usp_DanhSach_TSX 'TS01'

--B. In bảng chấm công trong tháng của 1 công nhân cho trước (TÊN SP, DVT, SL SX trong tháng, đơn giá, thành tiền)
Drop proc usp_BangChamCong
Create proc usp_BangChamCong @manv char(5), @thang int
AS
	If not exists(Select A.MaCN From CongNhan A Where @manv=A.MaCN)
		print N'Không có công nhân này !'
	else
		Select TenSP,DVT,Sum(SoLuong) as TongSL, TienCong, Sum(TienCong*SoLuong) as ThanhTien
		From CongNhan A, SanPham B, ThanhPham C
		Where A.MaCN = C.MaCN and B.MaSP=C.MaSP and A.MaCN=@manV and MONTH(Ngay)=@thang
		Group by TenSP, DVT, TienCong
Go
---------------------------
exec usp_BangChamCong 'CN001', 2
