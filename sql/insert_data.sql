USE QLCH;

SET FOREIGN_KEY_CHECKS = 0;


-- DỮ LIỆU DANH MỤC CƠ BẢN


-- CHỨC VỤ
INSERT INTO ChucVu VALUES
(1,'Quản lý'),(2,'Nhân viên bán hàng'),
(3,'Thủ kho'),(4,'Kế toán'),
(5,'Bảo vệ'),(6,'Thu ngân'),(7,'CSKH');

-- BỘ PHẬN
INSERT INTO BoPhan VALUES
(1,'Kinh doanh','Nguyễn Văn Minh','0901111222',NULL),
(2,'Kho','Trần Văn Long','0902222333',NULL),
(3,'Kế toán','Phạm Thị Mai','0903333444',NULL),
(4,'Nhân sự','Lê Thanh Hòa','0904444555',NULL);

-- NHÂN VIÊN (15 người, có cả full-time & part-time)

INSERT INTO NhanVien VALUES
(1,1,'Nam','0901111001','1985-05-15','Vạn Phúc, Hà Đông, Hà Nội',1,'Nguyễn Văn A'),
(2,2,'Nữ','0901111002','1992-04-10','Hoàn Kiếm, Hà Nội',1,'Trần Thị B'),
(3,3,'Nam','0901111003','1990-03-22','Nam Đồng, Hải Phòng',2,'Phạm Văn C'),
(4,2,'Nữ','0901111004','1994-12-01','Đông A, Nam Định',1,'Lê Thị D'),
(5,4,'Nữ','0901111005','1989-11-21','Phúc La, Hà Đông, Hà Nội',3,'Phan Thị E'),
(6,5,'Nam','0901111006','1980-07-30','Phú Lãm, Hà Đông, Hà Nội',4,'Hoàng Văn F'),
(7,6,'Nam','0901111007','1996-08-09','Yên Nghĩa, Hà Đông, Hà Nội',1,'Đỗ Quang G'),
(8,7,'Nữ','0901111008','1997-10-10','Vạn Phúc, Hà Đông, Hà Nội',1,'Vũ Thị H'),
(9,2,'Nam','0901111009','1993-05-18','Vũ Ninh, Bắc Ninh',1,'Trần Văn I'),
(10,3,'Nữ','0901111010','1990-09-05','Việt Hòa, Hải Phòng',2,'Phạm Thị K'),
(11,2,'Nam','0901111011','1995-04-04','Ba Đình, Hà Nội',1,'Nguyễn Văn L'),
(12,6,'Nữ','0901111012','1998-06-06','Nga An, Thanh Hóa',1,'Đào Thị M'),
(13,2,'Nam','0901111013','1991-02-20','Từ Liêm, Hà Nội',1,'Nguyễn Văn N'),
(14,7,'Nữ','0901111014','1999-08-25','Giảng Võ, Hà Nội',1,'Vũ Thị O'),
(15,5,'Nam','0901111015','1982-12-30','Giảng Võ, Hà Nội',4,'Đặng Văn P');

-- NHÂN VIÊN FULLTIME
INSERT INTO NhanVien_FullTime VALUES
(1,'HĐ001',15000000),(2,'HĐ002',9000000),(3,'HĐ003',10000000),
(5,'HĐ004',12000000),(7,'HĐ005',8000000),(9,'HĐ006',8500000);

-- NHÂN VIÊN PARTTIME
INSERT INTO NhanVien_PartTime VALUES
(4,120,50000),(6,80,40000),(8,100,45000),(10,70,45000),
(11,90,50000),(12,100,55000),(13,60,60000);

-- BẢNG LƯƠNG
INSERT INTO Luong VALUES
(1,202503,1,1000000,'2020-01-01'),
(2,202503,0,800000,'2021-03-15'),
(3,202503,2,500000,'2019-06-01'),
(4,202503,0,0,'2022-01-10'),
(5,202503,0,1200000,'2018-09-01'),
(6,202503,0,600000,'2019-02-01'),
(7,202503,0,300000,'2020-05-01');

-- KHÁCH HÀNG (20 khách)

INSERT INTO KhachHang VALUES
(101,'Nguyễn An','0909000001','Nam','Q1, TP.HCM','012345678','an@gmail.com','111111111'),
(102,'Trần Bình','0909000002','Nam','Q3, TP.HCM','123456789','binh@gmail.com','222222222'),
(103,'Lê Chi','0909000003','Nữ','Hà Đông, Hà Nội','234567891','chi@gmail.com','333333333'),
(104,'Phạm Dương','0909000004','Nam','Đà Nẵng',NULL,'duong@gmail.com','444444444'),
(105,'Vũ Em','0909000005','Nữ','Cầu Giấy, Hà Nội',NULL,'em@gmail.com','555555555'),
(106,'Hoàng Gia','0909000006','Nam','Bình Dương',NULL,'gia@gmail.com','666666666'),
(107,'Đỗ Hạnh','0909000007','Nữ','Bắc Ninh',NULL,'hanh@gmail.com','777777777'),
(108,'Lâm Khoa','0909000008','Nam','Thủ Đức, TP.HCM',NULL,'khoa@gmail.com','888888888'),
(109,'Trịnh Lan','0909000009','Nữ','Hải Dương',NULL,'lan@gmail.com','999999999'),
(110,'Phan Minh','0909000010','Nam','Nam Định',NULL,'minh@gmail.com','101010101'),
(111,'Lý Nam','0909000011','Nam','TP.HCM',NULL,'lynam@gmail.com','111111112'),
(112,'Đinh Oanh','0909000012','Nữ','Thái Bình',NULL,'oanh@gmail.com','121212121'),
(113,'Nguyễn Phú','0909000013','Nam','Cần Thơ',NULL,'phu@gmail.com','131313131'),
(114,'Vũ Quân','0909000014','Nam','Hà Nam',NULL,'quan@gmail.com','141414141'),
(115,'Trần Rịa','0909000015','Nữ','Bà Rịa',NULL,'ria@gmail.com','151515151'),
(116,'Hoàng Sơn','0909000016','Nam','Đà Lạt',NULL,'son@gmail.com','161616161'),
(117,'Phạm Trang','0909000017','Nữ','Long An',NULL,'trang@gmail.com','171717171'),
(118,'Lê Uyên','0909000018','Nữ','Bến Tre',NULL,'uyen@gmail.com','181818181'),
(119,'Đỗ Vũ','0909000019','Nam','Cà Mau',NULL,'vu@gmail.com','191919191'),
(120,'Bùi Xuân','0909000020','Nam','Hà Tĩnh',NULL,'xuan@gmail.com','202020202');

-- KHÁCH HÀNG VIP
INSERT INTO KhachHang_VIP VALUES (101,10.00),(105,5.00),(110,7.00),(115,8.00);

-- KHÁCH HÀNG THÀNH VIÊN
INSERT INTO KhachHang_ThanhVien VALUES
(102,'2024-11-01',120,'Silver'),
(103,'2023-06-15',450,'Gold'),
(104,'2025-02-10',60,'Bronze'),
(106,'2022-09-01',800,'Diamond'),
(107,'2024-01-12',300,'Silver');

-- PHẢN HỒI KHÁCH HÀNG
INSERT INTO PhanHoi VALUES
(1,101,'Sản phẩm tốt','Đóng gói cẩn thận'),
(2,102,'Giao hàng nhanh','Nhân viên thân thiện'),
(3,103,'Hài lòng','Giá cả hợp lý'),
(4,104,'Chưa ưng','Giao sai mẫu'),
(5,105,'Tốt','Sẽ ủng hộ lần sau');

--  NHÀ CUNG CẤP, HỢP ĐỒNG, LÔ HÀNG

INSERT INTO NhaCungCap VALUES
(201,'Công ty TNHH ABC','Hà Nội','0901234567','abc@abc.vn','01020304','111111'),
(202,'Công ty CP Thực phẩm Việt','TP.HCM','0902345678','vietfood@vn.vn','02030405','222222'),
(203,'Nhà cung cấp Minh Phát','Đà Nẵng','0903456789','minhphat@gmail.com','03040506','333333'),
(204,'Công ty TNHH Hoàng Gia','Hải Phòng','0904567890','hg@hg.vn','04050607','444444'),
(205,'Công ty TNHH Vạn An','Bình Dương','0905678901','vanan@gmail.com','05060708','555555');

INSERT INTO HopDong VALUES
(301,201,'2024-01-01','2025-01-01',100000000,'Thanh toán sau 30 ngày','Hiệu lực','Giao hàng đúng hạn'),
(302,202,'2024-03-01','2025-03-01',80000000,'Chiết khấu 5%','Hiệu lực','Không giao chậm'),
(303,203,'2024-06-01','2025-06-01',50000000,'Trả chậm 15 ngày','Hiệu lực','Đảm bảo chất lượng');

INSERT INTO LoHang VALUES
(401,301,'2025-09-20',200,10000000,'2025-09-01','2026-09-01','Tốt','Đạt'),
(402,302,'2025-09-21',150,8000000,'2025-09-05','2026-09-05','Tốt','Đạt'),
(403,303,'2025-09-22',100,6000000,'2025-09-10','2026-09-10','Tốt','Đạt');

--  LOẠI HÀNG + HÀNG HÓA

INSERT INTO LoaiHang VALUES
(501,'Đồ uống','Xanh','Việt Nam'),
(502,'Bánh kẹo','Đỏ','Việt Nam'),
(503,'Gia vị','Vàng','Thái Lan'),
(504,'Sữa','Trắng','Hà Lan'),
(505,'Rau củ','Xanh lá','Việt Nam');

INSERT INTO HangHoa VALUES
(601,'Coca Cola lon 330ml',501,10000,500,'2025-01-01','2026-01-01'),
(602,'Pepsi lon 330ml',501,9500,400,'2025-01-01','2026-01-01'),
(603,'Snack Oishi 50g',502,7000,300,'2025-03-01','2026-03-01'),
(604,'Mì Hảo Hảo tôm chua cay',502,4000,2000,'2025-04-01','2026-04-01'),
(605,'Dầu ăn Simply 1L',503,48000,800,'2025-01-10','2026-01-10'),
(606,'Sữa Vinamilk 1L',504,32000,500,'2025-03-05','2025-12-05'),
(607,'Sữa TH True Milk 180ml',504,9000,600,'2025-03-05','2025-12-05'),
(608,'Rau cải xanh 500g',505,12000,80,'2025-10-01','2025-10-10'),
(609,'Khoai tây 1kg',505,25000,100,'2025-10-01','2025-10-10'),
(610,'Nước tương Maggi 700ml',503,26000,250,'2025-02-12','2026-02-12');

-- HÓA ĐƠN & CHI TIẾT HÓA ĐƠN

INSERT INTO HoaDon VALUES
(701,'2025-10-01','2025-10-02',2,101),
(702,'2025-10-02','2025-10-03',4,102),
(703,'2025-10-03','2025-10-04',2,103),
(704,'2025-10-04','2025-10-05',7,104),
(705,'2025-10-05','2025-10-06',11,105);

INSERT INTO ChiTietHoaDon VALUES
(701,601,5,50000),(701,602,4,38000),(701,603,2,14000),
(702,604,10,40000),(702,605,1,48000),(702,606,2,64000),
(703,607,4,36000),(703,608,2,24000),(703,609,1,25000),
(704,601,6,60000),(704,610,2,52000),(704,606,1,32000),
(705,602,10,95000),(705,603,5,35000),(705,607,3,27000);

-- PHIẾU NHẬP & CHI TIẾT PHIẾU NHẬP


INSERT INTO PhieuNhap VALUES
(801,'2025-09-20',3,201,5000000),
(802,'2025-09-22',3,202,4000000),
(803,'2025-09-25',3,203,6000000);

INSERT INTO ChiTietPhieuNhap VALUES
(801,601,200,8000),(801,602,200,7600),(801,603,100,5000),
(802,604,300,3500),(802,605,100,42000),(803,606,150,26000),
(803,607,200,7000),(803,610,150,20000);

-- PHIẾU XUẤT & CHI TIẾT PHIẾU XUẤT

INSERT INTO PhieuXuat VALUES
(901,'2025-10-01',3,101,3000000),
(902,'2025-10-02',3,102,2500000);

INSERT INTO ChiTietPhieuXuat VALUES
(901,601,50,9000),(901,602,30,8800),(901,603,40,6000),
(902,604,100,3500),(902,605,20,46000),(902,606,30,29000);

-- PHIẾU CHI

INSERT INTO PhieuChi VALUES
(1001,'2025-10-01',1500000,'Chi mua văn phòng phẩm','Tiền mặt','Đã duyệt',5,'Hoàn thành','PC001'),
(1002,'2025-10-02',2500000,'Chi sửa chữa kho hàng','Chuyển khoản','Đã duyệt',3,'Hoàn thành','PC002'),
(1003,'2025-10-03',1000000,'Chi tiếp khách','Tiền mặt','Chờ duyệt',2,'Chờ duyệt','PC003');

SET FOREIGN_KEY_CHECKS = 1;

