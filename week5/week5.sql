--cau a
create table khach_hang(
	maKH char(5) primary key,
	Hoten nvarchar(30),
	SoDT char(12),
	Coquan nvarchar(50)
)

create table nha_cho_thue(
	maN char(5) primary key,
	Diachi nvarchar(100),
	Giathue money,
	Tenchunha nvarchar(30)
)

create table hop_dong(
	maN char(5),
	maKH char(5),
	Ngaybatdau date,
	ngayketthuc date,
	primary key (maN, maKH),
	constraint maN_fk foreign key (maN) references nha_cho_thue,
	constraint maKH_fk foreign key (maKH) references khach_hang
)


insert into khach_hang (maKH, Hoten, SoDT, Coquan) values
('KH01', N'Lương Dũng Trí', '881-572-6571', N'Công ty TNHH Vật liệu mới Haixin Việt Nam'),
('KH02', N'Nguyễn Anh Khải', '325-161-2684', N'Công ty TNHH Microtechno Việt Nam'),
('KH03', N'Ngô Khắc Vũ', '686-240-7850', N'Công ty TNHH liên doanh Gas Việt Nhật Miền Bắc'),
('KH04', N'Nguyễn Xuân Bình', '864-665-9235', N'Công ty TNHH Sypanel Vina'),
('KH05', N'Nguyễn Tấn Nam', '266-974-8409', N'Công ty TNHH BM VINA'),
('KH06', N'Phạm Ðông Dương', '203-200-9564', N'Công ty TNHH chỉ sợi và dây dệt New Order'),
('KH07', N'Võ Khánh An', '232-684-3855', N'CÔNG TY TNHH ORGANO (VIỆT NAM)'),
('KH08', N'Đặng Bảo Sơn', '611-396-5257', N'Công ty TNHH Dây Cáp Điện ô tô Sumiden Việt Nam'),
('KH09', N'Bùi Thanh Tú', '149-334-0149', N'Công ty TNHH Shoei Việt Nam'),
('KH10', N'Võ Trung Hải', '655-225-0825', N'Công ty TNHH Toei Việt Nam'),
('KH11', N'Nguyễn Quang Thịnh', '197-554-4771', N'Công ty TNHH DSM Việt Nam'),
('KH12', N'Dương Thế Dũng', '380-456-9178', N'Công ty TNHH Akebono Brake Astra Việt Nam'),
('KH13', N'Phạm Trọng Hà', '579-569-2092',	N'Công ty TNHH Denyo Việt Nam'),
('KH14', N'Vũ Gia Kiệt', '238-787-2055', N'CÔNG TY TNHH PANASONIC VIỆT NAM'),
('KH15', N'Nguyễn Duy Tân', '984-510-7428', N'Công ty TNHH Topy Fasteners Việt Nam')

insert into nha_cho_thue (maN, Diachi, Giathue, Tenchunha) values
('HM01', N'37/4 Phuong Mai, Dong Da District, Hanoi', 1354124, N'Thịnh Nam Dương'),
('HM02', N'14 Nam Ngu Street, Hoan Kiem District, Ha Noi', 31565484, N'Thịnh Danh Quỳnh'),
('HM03', N'3B Truong Chinh, Thanh Xuan District, Ha Noi', 12483487,	N'Đinh Ðức Quảng'),
('HM04', N'295 Pham Van Chi St., Ward 3, Dist. 6, Ho Chi Minh City', 12597623, N'Nông Văn Dền'),
('HM05', N'84 DT745 Dong Tu Ward, Lai Thieu Town, Binh Duong', 5623248,	N'Nguyễn Tuấn Tú'),
('HM06', N'Floor 3, 12 Hoa Binh Street, An Cu Ward, Can Tho City', 9321564,	N'Hoàng Ðức Tài'),
('HM07', N'4 LE LOI STREET, WARD 1, Vung Tau City', 8751987, N'Phạm Trường Chinh'),
('HM08', N'No. 15 Le Duan, District Hai Chau, Da Nang', 15631644, N'Nguyễn Tân Thành'),
('HM09', N'Phu Loi A Hamlet, Phu Kiet Ward, Tien Giang', 12055687, N'Phan Ðình Nam'),
('HM10', N'514 National Highway 1, Ward 4, Tan An Town, Long An', 1354218, N'Hồ Quang Hùng')

insert into hop_dong (maN, maKH, Ngaybatdau, ngayketthuc) values
('HM09', 'KH04', '1991/7/16', '1993/7/2'),
('HM03', 'KH08', '1992/9/20', '1993/11/6'),
('HM07', 'KH10', '1994/1/27', '1999/5/19'),
('HM09', 'KH07', '1995/2/9', '1997/5/29'),
('HM04', 'KH12', '1997/8/13', '1998/6/12'),
('HM01', 'KH01', '2000/2/21', '2003/12/22'),
('HM04', 'KH03', '2000/6/26', '2004/12/31'),
('HM07', 'KH13', '2000/8/28', '2006/10/10'),
('HM08', 'KH15', '2002/7/16', '2003/3/14'),
('HM06', 'KH11', '2005/3/24', '2007/2/7')

--cau b
select Diachi, Tenchunha from nha_cho_thue  
where Giathue < 10000000

select k.maKH, k.Hoten, k.Coquan from khach_hang k 
inner join (
select h.maKH, h.maN, n.Tenchunha from hop_dong h
inner join nha_cho_thue n on n.maN = h.maN ) a
on a.maKH = k.maKH
where a.Tenchunha = N'Nông Văn Dền'

select maN, Tenchunha, Diachi from nha_cho_thue where maN not in
( select maN from hop_dong group by maN )

select MAX(Giathue) as gia_thue_max from(
select n.maN, n.Giathue from nha_cho_thue n
inner join hop_dong h on n.maN = h.maN
group by n.Giathue, n.maN) as a

--cau c
create index co_quan on khach_hang(coquan)

select maKH, Hoten, SoDT, Coquan from khach_hang 
where Coquan like '%m'

create index ma_nha on nha_cho_thue(maN)
select a.maN, a.Tenchunha, b.SoNhaChoThue from nha_cho_thue as a 
inner join (select maN, count(maN) as SoNhaChoThue from hop_dong group by maN ) as b on a.maN = b.maN;

--cau d
CREATE PROCEDURE excepted_values
AS (
    SELECT h.maN, maKH, Ngaybatdau, Ngayketthuc, n.Giathue
    FROM hop_dong h, nha_cho_thue n
    WHERE h.maN = n.maN AND n.Giathue > 9999999)

EXEC excepted_values;

CREATE PROCEDURE total_price
as(
	select hoten, p.maKH, p.maN, p.time * p.Giathue from (
		SELECT h.maKH, h.maN, (datediff(month, h.ngaybatdau,h.ngayketthuc)) AS "time", n.Giathue from hop_dong h
		inner join nha_cho_thue n on h.maN = n.maN) as p
	inner join khach_hang k on k.maKH = p.maKH )
