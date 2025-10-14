
-- TẠO CƠ SỞ DỮ LIỆU
CREATE DATABASE IF NOT EXISTS QLCH
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE QLCH;

-- BẢNG CHỨC VỤ
CREATE TABLE ChucVu (
    MaChucVu INT PRIMARY KEY,
    TenChucVu VARCHAR(100)
) ENGINE=InnoDB;

-- BẢNG BỘ PHẬN
CREATE TABLE BoPhan (
    MaBoPhan INT PRIMARY KEY,
    TenBoPhan VARCHAR(100),
    ToTruong VARCHAR(100),
    SoDienThoaiBP VARCHAR(20),
    MaNhanVien INT
) ENGINE=InnoDB;

-- BẢNG NHÂN VIÊN
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY,
    MaChucVu INT,
    GioiTinh VARCHAR(10),
    SoDienThoai VARCHAR(20),
    NgaySinh DATE,
    DiaChi VARCHAR(255),
    MaBoPhan INT,
    HoVaTen VARCHAR(100),
    FOREIGN KEY (MaChucVu) REFERENCES ChucVu(MaChucVu),
    FOREIGN KEY (MaBoPhan) REFERENCES BoPhan(MaBoPhan)
) ENGINE=InnoDB;

-- BẢNG NHÂN VIÊN FULLTIME
CREATE TABLE NhanVien_FullTime (
    MaNhanVien INT PRIMARY KEY,
    HopDongDaiHan VARCHAR(20),
    LuongCoBan DECIMAL(12,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
) ENGINE=InnoDB;

-- BẢNG NHÂN VIÊN PARTTIME
CREATE TABLE NhanVien_PartTime (
    MaNhanVien INT PRIMARY KEY,
    SoGioLam INT,
    LuongTheoGio DECIMAL(12,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
) ENGINE=InnoDB;

-- BẢNG LƯƠNG
CREATE TABLE Luong (
    MaNhanVien INT PRIMARY KEY,
    ThoiGian INT,
    NghiKhongPhep INT,
    LuongThang13 DECIMAL(12,2),
    NgayBatDau DATE,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
) ENGINE=InnoDB;

-- BẢNG NHÀ CUNG CẤP
CREATE TABLE NhaCungCap (
    MaNhaCungCap INT PRIMARY KEY,
    TenNhaCungCap VARCHAR(150),
    DiaChi VARCHAR(255),
    SoDienThoai VARCHAR(20),
    Email VARCHAR(50),
    MST VARCHAR(20),
    STK VARCHAR(30)
) ENGINE=InnoDB;

-- BẢNG HỢP ĐỒNG
CREATE TABLE HopDong (
    MaHopDong INT PRIMARY KEY,
    MaNhaCungCap INT,
    NgayKyKet DATE,
    NgayHetHan DATE,
    GiaTriHopDong DECIMAL(14,2),
    DieuKhoan VARCHAR(255),
    TrangThai VARCHAR(50),
    GhiChu VARCHAR(255),
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
) ENGINE=InnoDB;

-- BẢNG LÔ HÀNG
CREATE TABLE LoHang (
    MaLoHang INT PRIMARY KEY,
    MaHopDong INT,
    NgayNhap DATE,
    SoLuongNhap INT,
    TongGiaTri DECIMAL(14,2),
    NgaySX DATE,
    HSD DATE,
    TinhTrang VARCHAR(30),
    GhiChu VARCHAR(255),
    FOREIGN KEY (MaHopDong) REFERENCES HopDong(MaHopDong)
) ENGINE=InnoDB;

-- BẢNG LOẠI HÀNG
CREATE TABLE LoaiHang (
    MaLoaiHang INT PRIMARY KEY,
    TenLoaiHang VARCHAR(100),
    MauMa VARCHAR(50),
    NoiSanXuat VARCHAR(100)
) ENGINE=InnoDB;

-- BẢNG HÀNG HÓA
CREATE TABLE HangHoa (
    MaHH INT PRIMARY KEY,
    TenHangHoa VARCHAR(100),
    MaLoaiHang INT,
    GiaBan DECIMAL(12,2),
    SoLuong INT,
    NgaySX DATE,
    HSD DATE,
    FOREIGN KEY (MaLoaiHang) REFERENCES LoaiHang(MaLoaiHang)
) ENGINE=InnoDB;

-- BẢNG PHIẾU NHẬP
CREATE TABLE PhieuNhap (
    MaPhieuNhap INT PRIMARY KEY,
    NgayNhap DATE,
    MaNhanVien INT,
    MaNhaCungCap INT,
    TongGiaTri DECIMAL(14,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
) ENGINE=InnoDB;

-- CHI TIẾT PHIẾU NHẬP
CREATE TABLE ChiTietPhieuNhap (
    MaPhieuNhap INT,
    MaHH INT,
    SoLuongNhap INT,
    DonGiaNhap DECIMAL(12,2),
    PRIMARY KEY (MaPhieuNhap, MaHH),
    FOREIGN KEY (MaPhieuNhap) REFERENCES PhieuNhap(MaPhieuNhap),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH)
) ENGINE=InnoDB;

-- BẢNG PHIẾU XUẤT
CREATE TABLE PhieuXuat (
    MaPhieuXuat INT PRIMARY KEY,
    NgayXuat DATE,
    MaNhanVien INT,
    MaKhachHang INT,
    TongGiaTri DECIMAL(14,2),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
) ENGINE=InnoDB;

-- CHI TIẾT PHIẾU XUẤT
CREATE TABLE ChiTietPhieuXuat (
    MaPhieuXuat INT,
    MaHH INT,
    SoLuongXuat INT,
    DonGiaXuat DECIMAL(12,2),
    PRIMARY KEY (MaPhieuXuat, MaHH),
    FOREIGN KEY (MaPhieuXuat) REFERENCES PhieuXuat(MaPhieuXuat),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH)
) ENGINE=InnoDB;

-- BẢNG KHÁCH HÀNG
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    TenKhachHang VARCHAR(100),
    SDT VARCHAR(20),
    GioiTinh VARCHAR(10),
    DiaChi VARCHAR(255),
    CCCD VARCHAR(20),
    Email VARCHAR(50),
    STK VARCHAR(30)
) ENGINE=InnoDB;

-- KHÁCH HÀNG VIP
CREATE TABLE KhachHang_VIP (
    MaKhachHang INT PRIMARY KEY,
    MucGiamGia DECIMAL(5,2),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
) ENGINE=InnoDB;

-- KHÁCH HÀNG THÀNH VIÊN
CREATE TABLE KhachHang_ThanhVien (
    MaKhachHang INT PRIMARY KEY,
    NgayDangKy DATE,
    DiemTichLuy INT,
    LoaiThe VARCHAR(60),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
) ENGINE=InnoDB;

-- PHẢN HỒI KHÁCH HÀNG
CREATE TABLE PhanHoi (
    MaPhanHoi INT PRIMARY KEY,
    MaKhachHang INT,
    DanhGiaSanPham VARCHAR(255),
    DongGop VARCHAR(255),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
) ENGINE=InnoDB;

-- HÓA ĐƠN BÁN
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY,
    NgayLapHoaDon DATE,
    NgayNhanHang DATE,
    MaNhanVien INT,
    MaKhachHang INT,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
) ENGINE=InnoDB;

-- CHI TIẾT HÓA ĐƠN
CREATE TABLE ChiTietHoaDon (
    MaHoaDon INT,
    MaHH INT,
    SoLuong INT,
    ThanhTien DECIMAL(12,2),
    PRIMARY KEY (MaHoaDon, MaHH),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaHH) REFERENCES HangHoa(MaHH)
) ENGINE=InnoDB;

-- PHIẾU CHI (CHI PHÍ)
CREATE TABLE PhieuChi (
    MaPhieuChi INT PRIMARY KEY,
    NgayChi DATE,
    SoTien DECIMAL(12,2),
    LyDoChi VARCHAR(255),
    HinhThucThanhToan VARCHAR(30),
    GhiChu VARCHAR(255),
    MaNhanVien INT,
    TrangThai VARCHAR(30),
    SoToChungTu VARCHAR(50),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
) ENGINE=InnoDB;
