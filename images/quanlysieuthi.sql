# Cơ sở dữ liệu: 'Quản lý siêu thị nhỏ'
CREATE DATABASE QLSTN;
USE QLSTN;

# Cấu trúc bảng cho bảng 'ChucVu'
CREATE TABLE ChucVu (
    MaChucVu INT PRIMARY KEY,
    TenChucVu VARCHAR(20)
);

/*
 Đang đổ dũ liệu cho bảng 'ChucVu' 
*/
INSERT INTO ChucVu VALUES
(1, 'Quản lý'),
(2, 'Thu ngân'),
(3, 'Bán hàng'),
(4, 'Kho hàng'),
(5, 'Bảo vệ');

# Cấu trúc bảng cho bảng 'NhanVien'
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY,
    MaChucVu INT,
    HoVaTen VARCHAR(100),
    GioiTinh VARCHAR(10),
    SoDienThoai VARCHAR(15),
    NgaySinh DATE,
    DiaChi VARCHAR(255),
    FOREIGN KEY (MaChucVu) REFERENCES ChucVu(MaChucVu)
);

/*
 Đang đổ dũ liệu cho bảng 'NhanVien'
*/
INSERT INTO NhanVien VALUES
(1, 1, 'Nguyễn Văn A', 'Nam', '0901234567', '1990-01-01', 'Hà Nội'),
(2, 2, 'Trần Thị B', 'Nữ', '0902345678', '1995-02-12', 'Hà Nội'),
(3, 3, 'Lê Văn C', 'Nam', '0903456789', '1998-03-22', 'Bắc Ninh'),
(4, 4, 'Phạm Thị D', 'Nữ', '0904567890', '1999-04-10', 'Hải Dương'),
(5, 5, 'Hoàng Văn E', 'Nam', '0905678901', '1988-05-15', 'Hà Nội');

# Cấu trúc bảng cho bảng 'FullTime'
CREATE TABLE FullTime (
    MaNhanVien INT PRIMARY KEY,
    HopDongDaiHan VARCHAR(20),
    LuongCoBan DECIMAL(10,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

/*
 Đang đổ dũ liệu cho bảng 'FullTime'
*/
INSERT INTO FullTime VALUES
(1, '3 năm', 15000000.00),
(2, '2 năm', 12000000.00);

# Cấu trúc bảng cho bảng 'PartTime'
CREATE TABLE PartTime (
    MaNhanVien INT PRIMARY KEY,
    SoGioLam DECIMAL(5,2),
    LuongTheoGio DECIMAL(10,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

/*
 Đang đổ dũ liệu cho bảng 'PartTime'
*/
INSERT INTO PartTime VALUES
(3, 120.5, 30000.00),
(4, 100.0, 28000.00),
(5, 80.0, 25000.00);

# Cấu trúc bảng cho bảng  'Luong'
CREATE TABLE Luong (
    MaNhanVien INT PRIMARY KEY,
    ThoiGian INT,
    NghiKhongPhep INT,
    LuongThang13 DECIMAL(10,2),
    NgayBatDau DATE,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

/*
 Đang đổ dũ liệu cho bảng 'Luong'
*/
INSERT INTO Luong VALUES
(1, 36, 0, 10000000.00, '2020-01-01'),
(2, 24, 1, 8000000.00, '2021-03-01'),
(3, 12, 2, 5000000.00, '2022-05-10'),
(4, 10, 0, 3000000.00, '2023-01-01'),
(5, 8, 0, 2000000.00, '2024-01-01');

# Cấu trúc bảng cho bảng  'KhachHang'
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    TenKhachHang VARCHAR(100),
    SDT VARCHAR(15),
    GioiTinh VARCHAR(10),
    DiaChi VARCHAR(255)
);

/*
 Đang đổ dũ liệu cho bảng 'KhachHang'
*/
INSERT INTO KhachHang VALUES
(1, 'Nguyễn Thị Hoa', '0911111111', 'Nữ', 'Hà Nội'),
(2, 'Phạm Văn Minh', '0912222222', 'Nam', 'Bắc Giang'),
(3, 'Trần Thị Mai', '0913333333', 'Nữ', 'Hải Phòng'),
(4, 'Lê Văn Nam', '0914444444', 'Nam', 'Hà Nội'),
(5, 'Hoàng Thị Linh', '0915555555', 'Nữ', 'Hưng Yên');

# Cấu trúc bảng cho bảng 'HoaDon'
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY,
    NgayLapHoaDon DATE,
    NgayNhanHang DATE,
    MaNhanVien INT,
    MaKhachHang INT,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

/*
 Đang đổ dũ liệu cho bảng 'HoaDon'
*/
INSERT INTO HoaDon VALUES
(1, '2025-01-01', '2025-01-02', 2, 1),
(2, '2025-02-03', '2025-02-04', 3, 2),
(3, '2025-03-05', '2025-03-06', 3, 3),
(4, '2025-04-07', '2025-04-08', 4, 4),
(5, '2025-05-09', '2025-05-10', 2, 5);

# Cấu trúc bảng cho bảng 'LoaiHang'
CREATE TABLE LoaiHang (
    MaLoaiHang INT PRIMARY KEY,
    TenLoaiHang VARCHAR(100),
    MauMa VARCHAR(100),
    NoiSanXuat VARCHAR(255)
);

/*
 Đang đổ dũ liệu cho bảng 'LoaiHang'
*/
INSERT INTO LoaiHang VALUES
(1, 'Thực phẩm', 'Đỏ', 'Việt Nam'),
(2, 'Đồ uống', 'Xanh', 'Thái Lan'),
(3, 'Đồ gia dụng', 'Trắng', 'Trung Quốc');

# Cấu trúc bảng cho bảng 'HangHoa'
CREATE TABLE HangHoa (
    MaHH INT PRIMARY KEY,
    MaLoaiHang INT,
    TenHangHoa VARCHAR(100),
    SoLuong INT,
    NgaySX DATE,
    HSD DATE,
    GiaBan DECIMAL,
    FOREIGN KEY (MaLoaiHang) REFERENCES LoaiHang(MaLoaiHang)
);

/*
 Đang đổ dũ liệu cho bảng 'HangHoa'
*/
INSERT INTO HangHoa VALUES
(1, 1, 'Gạo ST25', 200, '2025-01-01', '2026-01-01', 25000.00),
(2, 2, 'Coca Cola', 500, '2025-02-01', '2026-02-01', 10000.00),
(3, 1, 'Mì Hảo Hảo', 300, '2025-01-10', '2026-01-10', 3500.00),
(4, 3, 'Bếp gas mini', 50, '2024-12-01', NULL, 150000.00),
(5, 2, 'Nước suối Lavie', 400, '2025-02-20', '2026-02-20', 7000.00);

# Cấu trúc bảng cho bảng 'ChiTietHoaDon'
CREATE TABLE ChiTietHoaDon (
    MaHoaDon INT,
    MaHH INT,
    SoLuong DECIMAL(10,2),
    PRIMARY KEY (MaHoaDon, MaHH),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH)
);

/*
 Đang đổ dũ liệu cho bảng 'ChiTietHoaDon'
*/
INSERT INTO ChiTietHoaDon VALUES
(1, 1, 5),
(1, 2, 3),
(2, 3, 10),
(3, 5, 20),
(4, 4, 2);

# Cấu trúc cho bảng 'PhanHoi'
CREATE TABLE PhanHoi (
    MaPhanHoi INT PRIMARY KEY,
    MaKhachHang INT,
    DanhGiaSanPham VARCHAR(255),
    DongGop VARCHAR(255),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

/*
 Đang đổ dũ liệu cho bảng 'PhanHoi'
*/
INSERT INTO PhanHoi VALUES
(1, 1, 'Sản phẩm tốt', 'Giao nhanh'),
(2, 2, 'Chất lượng ổn', 'Nên thêm mẫu mới'),
(3, 3, 'Giá hơi cao', 'Khuyến mãi thêm');

# Cấu trúc bảng cho bảng 'KhachHangVIP'
CREATE TABLE KhachHangVIP (
    MaKhachHang INT PRIMARY KEY,
    DiemTichLuy INT,
    MucGiamGia DECIMAL(5,2),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

/*
 Đang đổ dũ liệu cho bảng 'KhachHangVIP'
*/
INSERT INTO KhachHangVIP VALUES
(1, 1200, 10.00),
(2, 800, 7.50);

# Cấu trúc bảng cho bảng 'KhachHangThamNien'
CREATE TABLE KhachHangThamVien (
    MaKhachHang INT PRIMARY KEY,
    NgayDangKy DATE,
    LoaiThe VARCHAR(10),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

/*
 Đang đổ dũ liệu cho bảng 'KhachHangVIP'
*/
INSERT INTO KhachHangThanhVien VALUES
(1, '2022-05-01', 'Vàng'),
(3, '2023-06-15', 'Bạc'),
(5, '2024-01-20', 'Đồng');













