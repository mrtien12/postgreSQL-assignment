-- CREATE TABLE GiangVien(
-- 	"GV#" char(5) PRIMARY KEY,
-- 	HoTen char(30)	NOT NULL,
-- 	DiaChi char(30) NOT NULL,
-- 	NgaySinh date NOT NULL	
-- );

-- CREATE TABLE DeTai(
-- 	"DT#" char(5) PRIMARY KEY,
-- 	TenDT char(30),
-- 	Cap char(15),
-- 	KinhPhi int
-- );

-- CREATE TABLE ThamGia(
-- 	"GV#" char(5),
-- 	"DT#" char(5),
-- 	SoGio int,
-- 	PRIMARY KEY("GV#", "DT#"),
-- 	CONSTRAINT fk_gv FOREIGN KEY ("GV#") REFERENCES GiangVien,
-- 	CONSTRAINT fk_dt FOREIGN KEY ("DT#") REFERENCES DeTai
-- );


-- INSERT INTO GiangVien ("GV#", HoTen, DiaChi, NgaySinh) VALUES
-- ('GV01', 'Vũ Tuyết Trinh', 'Hoàng Mai, Hà Nội', '10/10/1975'),
-- ('GV02', 'Nguyễn Nhật Quang', 'Hai Bà Trưng, Hà Nội', '03/11/1976'),
-- ('GV03','Trần Đức Khánh','Đống Đa, Hà Nội','04/06/1977'),
-- ('GV04', 'Nguyễn Hồng Phương', 'Tây Hồ, Hà Nội', '10/12/1983'),
-- ('GV05','Lê Thanh Hương','Hai Bà Trưng, Hà Nội','10/10/1976');

-- INSERT INTO DeTai("DT#", TenDT, Cap, KinhPhi) VALUES
-- ('DT01', 'Tính toán lưới', 'Nhà nước', '700'),
-- ('DT02', 'Phát hiện tri thức', 'Bộ', '300'),
-- ('DT03', 'Phân loại văn bản', 'Bộ', '270'),
-- ('DT04', 'Dịch tự động Anh Việt', 'Trường', '30');

-- INSERT INTO ThamGia("GV#", "DT#", SoGio) VALUES
-- ('GV01','DT01','100'),
-- ('GV01','DT02','80'),
-- ('GV01','DT03','80'),
-- ('GV02','DT01','120'),
-- ('GV02','DT03','140'),
-- ('GV03','DT03','150'),
-- ('GV04','DT04','180');

-- 1
-- SELECT * FROM GiangVien WHERE DiaChi LIKE ('Hai Bà Trưng%');

-- 2
-- SELECT gv.HoTen, gv.DiaChi, gv.NgaySinh, dt.TenDT
-- FROM ThamGia tg
-- INNER JOIN GiangVien gv ON tg."GV#" = gv."GV#"
-- INNER JOIN DeTai dt ON tg."DT#" = dt."DT#"
-- WHERE dt.TenDT = 'Tính toán lưới';

-- 3
-- SELECT gv.HoTen, gv.DiaChi, gv.NgaySinh, dt.TenDT
-- FROM ThamGia tg
-- INNER JOIN GiangVien gv ON tg."GV#" = gv."GV#"
-- INNER JOIN DeTai dt ON tg."DT#" = dt."DT#"
-- WHERE dt.TenDT = 'Phân loại văn bản' OR dt.TenDT = 'Dịch tự động Anh Việt';
 
-- 4
-- SELECT gv.HoTen, gv."GV#", count('DT#') as soluong FROM ThamGia tg
-- INNER JOIN GiangVien gv ON tg."GV#" = gv."GV#"
-- GROUP BY gv."GV#"
-- HAVING COUNT('DT#') >= 2; 

-- 5
-- select hoten, k."GV#", k.soluong  from giangvien v
-- inner join (
-- 	select "GV#" , count("DT#") as soluong 
-- 	from thamgia
-- 	group by "GV#"
-- 	order by soluong desc
-- 	limit 1 ) k on 
-- k."GV#" = v."GV#";

--6 
-- SELECT "DT#" FROM (
-- 	select "DT#" FROM DeTai
-- 	order by (KinhPhi) asc limit 1
-- ) t

7

/*select G.hoten,g.ngaysinh,string_agg(T."DT#",',')
from thamgia t 
inner join giangvien g on 
t."GV#" = G."GV#"
where g.diachi like 'Tây Hồ%'
group by G."GV#" */
8
/*select g.hoten,g.ngaysinh
from giangvien g
inner join thamgia t
on g."GV#" = t."GV#"
where t."DT#" LIKE 'DT03%' and date_part('year', g.ngaysinh) < 1980*/
9
/*
select g.hoten,sum(t.sogio)
from giangvien g
inner join thamgia t
on g."GV#" = t."GV#"
GROUP by g.hoten
*/
10/*
INSERT into giangvien VALUES
('GV07','Ngô Tuấn Phong','Đống Đa, Hà Nội','08/09/1986')
*/
11.
/*
update giangvien
set diachi = 'Tây Hồ, Hà Nội'
where giangvien."GV#" = 'GV01'
*/
12.
/*
--DELETE from thamgia where thamgia."GV#" = 'GV02'
--DELETE from giangvien g where g."GV#"= = 'GV02'
*/
