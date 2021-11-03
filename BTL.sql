Create database BTL;
use BTL

Create table Nhanviencongty(
Ma_nv char(6) not Null primary key,
Ten_nv nvarchar(30),
Diachi_nv nvarchar(30),
Gioitinh_nv nvarchar(30),
SDT_nv char(12)
);

Create table KhachHang(
Ma_kh char(6) not Null primary key,
Ten_kh nvarchar(30),
Diachi_kh nvarchar(30),
Sdt_kh char(20)
);
3. Tạo bảng mặt hàng
Create table Mathang(
Ma_h char(6) not Null primary key,
Ten_h nvarchar(30) not Null,
HSD Date,
Giaban int
);
4. Tạo bảng kiểm kê
Create table KiemKe(
Ma_h char(6) not Null,
SLban int,
SLton int,
foreign key (Ma_h) references Mathang(Ma_h)
);
5. Tạo bảng hóa đơn
Create table Hoadonkhach(
Ma_hd char(6) not Null primary key,
Ma_nv char(6) not Null,
Ma_kh char(6) not Null,
Ma_h char(6) not Null,
Tenhang_hd nvarchar(30),
So_luong int,
Gia_ban int,
foreign key (ma_nv) references nhanviencongty(ma_nv),
foreign key (ma_kh) references khachhang(ma_kh),
foreign key (ma_h) references mathang(ma_h),
);

insert into KhachHang
Values('KH001',N'Đinh Vũ Quang',N'Hà Nội','0913961401'),
	  ('KH002',N'Nguyễn Đức Duy',N'Hà Nội','0913961400'),
	  ('KH003',N'Mộng Sơn Hải',N'Cao Bằng','0913961411'),
	  ('KH004',N'Nguyễn Tuấn Phong',N'Hà Nội','0913961412'),
	  ('KH005',N'Nguyễn Đức Minh',N'Hà Nội','0913961403');
	 Select *from KhachHang

insert into Nhanviencongty
Values
('NV01',N'Nguyễn Văn Anh',N'Hà Nội',N'Nam','0933961401'),
('NV02',N'Nguyễn Đức Anh',N'Hà Nội',N'Nam','0986961403'),
('NV03',N'Nguyễn Ngọc Nhi',N'Cao Bằng',N'Nữ','0913961503'),
('NV04',N'Trần Trang Thanh',N'Hà Nội',N'Nữ','0913961111'),
('NV05',N'Trần Ngọc Sơn',N'Hà Nội',N'Nam','0919961781');

Insert into Mathang
Values ('DL01',N'Tôm Sú','1/10/2021','200000'),
		('DL02',N'Há Cảo','1/10/2021','42000'),
		('DL03',N'Xúc Xích','1/10/2021','28000'),
		('DL04',N'Cá','1/10/2021','120000'),
		('DL05',N'Mực','1/10/2021','320000');

insert into KiemKe
Values ('DL01','100','300'),
		('DL02','40','260'),
		('DL03','98','202'),
		('DL04','40','260'),
		('DL05','200','300');

Insert into Hoadonkhach
Values('HD001','NV01','KH001','DL01',N'Tôm Sú','1','200000'),
	('HD002','NV03','KH002','DL02',N'Há Cảo','3','126000'),
	('HD003','NV02','KH003','DL03',N'Xúc Xích','2','56000'),
	('HD004','NV01','KH004','DL04',N'Cá','1','120000'),
	('HD005','NV04','KH005','DL05',N'Mực','1','320000');
	Select *from Hoadonkhach

Select *from KiemKe
/*1 Đưa ra tên thông tin Kiểm kê */
Select *From KiemKe;

/*2 Đưa ra nhân vien có giới tính là Nữ*/
Select * from Nhanviencongty
where Gioitinh_nv like N'Nữ';

/*3 Đưa ra số lượng tồn trong kiểm kê từ cao đến thấp*/
Select *from KiemKe
order by SLton desc;

/*4 Đưa hóa đơn khách mua há cảo */
select *from Hoadonkhach
where Tenhang_hd like N'Há Cảo';

/*5  Đưa ra mặt hàng có số tiền  lớn nhất */
select ten_h, giaban as mathangcogiatienlonnhat from mathang
where giaban = (select max(giaban) from Mathang)

/*6 đưa ra địa chỉ khách hàng tên Quang */
select ten_kh from KhachHang
where ten_kh like N'%Quang'

/*7 đưa ra số lương bán trong kiểm kê*/
select Ma_h, SLBan from KiemKe

/*8 đưa ra tên nhân viên có địa chỉ Hà Nội*/
select ten_nv from Nhanviencongty
where Diachi_nv like N'Hà Nội';

/*9 tính giá trị tổng của sl bán được*/
select sum(SLban) as So_luong_hang_trong_kho from KiemKe

/*10 đưa ra hóa đơn khách mua nhiều nhất*/
select Ma_kh,So_luong as sodokhachmuanhieunhat from Hoadonkhach
where So_luong=(select max(so_luong) from Hoadonkhach)

/*11 đưa ra mặt hàng có hạn sử dụng là 1/10/2021*/
select ten_h from Mathang
where HSD  ='1/10/2021'

/*12 đưa ra số điện thoại của nhân viên*/
select ten_nv, sdt_nv from Nhanviencongty

/*13 đưa ra sản phẩm tên mực và giá tiền*/
select ten_h,Giaban from Mathang
where Ten_h like N'Mực'

/*14 sắp xêp thứ tự giảm dần số tiền hóa đơn khách */
select * from hoadonkhach
order by Gia_ban desc;

/*15 tổng số tiền bán đc trong bảng*/
select sum(Gia_ban) as Sotienbandc from Hoadonkhach

-- Hàm trả về số lượng mã hàng mua của 1 hóa đơn bất kì
create function fn_demslgsp(@Ma_hd nvarchar(30))
returns int as 
begin 
	declare @slg int;
	select @slg = So_luong
	from Hoadonkhach
	where Ma_hd = @Ma_hd;
	if (@slg is null)
	set @slg = 0;
	return @slg;
end

select dbo.fn_demslgsp('HD002')
-- Thủ tục thêm dữ liệu vào bảng Hoadonkhach với các tham số là các dữ liệu cần thêm vào các cột 
create proc sp_themHd(@Ma_hd char(6), @Ma_nv char(6), @Ma_kh char(6), @Ma_h char(6), @Tenhang_hd nvarchar(30), @So_luong int, @Gia_ban int)
as
	insert into Hoadonkhach
	Values (@Ma_hd, @Ma_nv, @Ma_kh, @Ma_h, @Tenhang_hd, @So_luong, @Gia_ban)

exec sp_themHd 'HD006', 'NV05', 'KH005', 'DL04', N'Cá', '6', '720000'
select * from Hoadonkhach

-- Trigger 
Create trigger trig_total on Hoadonkhach 
for insert as
if ((select Ma_h from inserted) is not null)
Begin 
	update Hoadonkhach
	set Gia_ban = So_luong * Mathang.Giaban
	from Mathang, (select Ma_h, Ma_hd from inserted) as I
	where Mathang.Ma_h = Hoadonkhach.Ma_h and Hoadonkhach.Ma_h = I.Ma_h and Hoadonkhach.Ma_hd = I.Ma_hd
End

exec sp_themHd 'HD007', 'NV04', 'KH004', 'DL03', N'Xúc xích', '3', '0'

select * from Hoadonkhach
-- vd2 của trigger
create trigger trig_updatekh
on KhachHang
for update
as
print N'Bạn đã cập nhật thành công trong bảng KhachHang'

update KhachHang
set Ten_kh = N'Nguyễn Thanh Thúy' where Ma_kh = 'KH005';

select * from KhachHang

-- View
create view Tongquan
as
select KhachHang.Ma_kh, KhachHang.Ten_kh, Hoadonkhach.Ma_hd, Hoadonkhach.Tenhang_hd, Hoadonkhach.So_luong, Hoadonkhach.Gia_ban
from KhachHang, Hoadonkhach
where KhachHang.Ma_kh = Hoadonkhach.Ma_kh


select * from Tongquan

-- con trỏ
declare con_tro_KH cursor 
dynamic scroll
for
	select Ma_kh, Ten_kh, Diachi_kh, Sdt_kh from KhachHang

Open con_tro_KH;

declare @Ten_kh nvarchar(30), @Ma_kh char(10), @Diachi_kh nvarchar(30);
fetch next from con_tro_KH into @Ten_kh, @Ma_kh, @Diachi_kh, @Sdt_kh
while (@@FETCH_STATUS =0)
Begin
	print @Ma_kh + N'tên là' + @Ten_kh + N'có địa chỉ tại' + @Diachi_kh + 'có số điện thoại' + Sdt_kh 
	fetch next from con_tro_KH into @Ten_kh, @Ma_kh, Diachi_kh, @Sdt_kh
End

Close con_tro_KH;
DeAllocate con_tro_KH;

-- 6. Phân quyền người dùng
-- tạo login 
sp_addlogin 'test', '123';
-- tạo user gắn vào login 
sp_grantdbaccess 'test', 'duy';
-- tạo role và cấp quyền cho role
sp_addrole nguoidung
grant select, insert, delete, update on KhachHang to nguoidung;
-- gắn người dùng vào role
sp_addrolemember 'nguoidung', 'hai';

-- 7. Transaction: Viết giao dịch thêm 1 nhân viên tên là Nguyễn Văn A, nếu đã có 1 nhân viên tên 
--Nguyễn Văn A không thực hiện giao dịch
declare @CountName int 
begin tran them_nv
insert into Nhanviencongty values
('NV07', N'Thái Bình Dương', N'Hà Nội', 'Nam', '0854431121')
select @CountName = count(*) from Nhanviencongty where Ten_nv = N'Thái Bình Dương'
if (@CountName > 1)
	begin 
		rollback tran them_nv
		print N'Hủy thêm nhân viên'
	end
else
	begin 
		commit tran them_nv
		print N'Thực hiện thêm bản ghi'
	end

select * from Nhanviencongty
delete from Nhanviencongty where Ten_nv = N'Thái Bình Dương';


