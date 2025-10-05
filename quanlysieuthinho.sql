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

# Cấu trúc bảng cho bảng 'KhachHangThamNien'
CREATE TABLE KhachHangThanhVien (
    MaKhachHang INT PRIMARY KEY,
    NgayDangKy DATE,
    LoaiThe VARCHAR(10),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

/*
 Đang đổ dũ liệu cho bảng 'KhachHangVIP'
*/













