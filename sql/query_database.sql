USE QLCH;

# Truy vấn thông tin: sản phẩm, số lượng, giá bán, thành tiền, tổng cộng. với bảng trên
SELECT 
    h.MaHoaDon,
    hh.TenHangHoa AS SanPham,
    cthd.SoLuong,
    hh.GiaBan,
    cthd.ThanhTien,
    SUM(cthd.ThanhTien) OVER (PARTITION BY h.MaHoaDon) AS TongCong
FROM ChiTietHoaDon cthd
JOIN HoaDon h 
    ON h.MaHoaDon = cthd.MaHoaDon
JOIN HangHoa hh 
    ON hh.MaHH = cthd.MaHH
WHERE h.MaHoaDon = 701;   -- Thay mã hóa đơn bạn muốn xem


# Truy vấn theo: mã hóa đơn, số điện thoại khách hàng, ngày, nhân viên.
SELECT 
    h.MaHoaDon,
    h.NgayLapHoaDon,
    nv.HoVaTen AS NhanVienLap,
    kh.TenKhachHang,
    kh.SDT,
    SUM(ct.ThanhTien) AS TongTien
FROM HoaDon h
JOIN NhanVien nv ON nv.MaNhanVien = h.MaNhanVien
JOIN KhachHang kh ON kh.MaKhachHang = h.MaKhachHang
JOIN ChiTietHoaDon ct ON ct.MaHoaDon = h.MaHoaDon
WHERE (h.MaHoaDon = 701 OR 701 IS NULL)                -- tìm theo mã hóa đơn
   OR (kh.SDT = '0987123456' OR '0987123456' IS NULL)  -- tìm theo số điện thoại
   OR (DATE(h.NgayLapHoaDon) = '2025-10-14' OR '2025-10-14' IS NULL)  -- theo ngày
   OR (nv.HoVaTen LIKE '%An%' OR '%An%' IS NULL)       -- theo nhân viên
GROUP BY h.MaHoaDon, h.NgayLapHoaDon, nv.HoVaTen, kh.TenKhachHang, kh.SDT;


# Tổng hợp doanh thu từng hóa đơn Truy vấn tổng tiền = số lượng × giá bán.
SELECT 
    h.MaHoaDon,
    h.NgayLapHoaDon,
    kh.TenKhachHang,
    nv.HoVaTen AS NhanVienLap,
    SUM(ct.SoLuong * hh.GiaBan) AS TongTienHoaDon
FROM HoaDon h
JOIN NhanVien nv ON nv.MaNhanVien = h.MaNhanVien
JOIN KhachHang kh ON kh.MaKhachHang = h.MaKhachHang
JOIN ChiTietHoaDon ct ON ct.MaHoaDon = h.MaHoaDon
JOIN HangHoa hh ON hh.MaHH = ct.MaHH
GROUP BY h.MaHoaDon, h.NgayLapHoaDon, kh.TenKhachHang, nv.HoVaTen
ORDER BY h.NgayLapHoaDon DESC;

# Truy vấn thông tin: tiền mặt, thẻ, chuyển khoản, mã QR.
SELECT 
    h.MaHoaDon,
    kh.TenKhachHang,
    nv.HoVaTen AS NhanVienLap,
    pc.HinhThucThanhToan,
    pc.SoTien,
    pc.NgayChi
FROM HoaDon h
JOIN KhachHang kh ON kh.MaKhachHang = h.MaKhachHang
JOIN NhanVien nv ON nv.MaNhanVien = h.MaNhanVien
JOIN PhieuChi pc ON pc.MaNhanVien = nv.MaNhanVien
WHERE pc.HinhThucThanhToan IN ('Tien mat', 'The', 'Chuyen khoan', 'Ma QR');

#Danh sách hàng hóa trong kho Truy vấn: mã hàng, tên, loại, giá, số lượng tồn, hạn sử dụng.
SELECT 
    hh.MaHH,
    hh.TenHangHoa,
    lh.TenLoaiHang,
    hh.GiaBan,
    hh.SoLuong AS SoLuongTon,
    hh.HSD
FROM HangHoa hh
JOIN LoaiHang lh ON hh.MaLoaiHang = lh.MaLoaiHang
ORDER BY lh.TenLoaiHang, hh.TenHangHoa;

# Tìm kiếm sản phẩm trong kho. Truy vấn theo: tên, loại, giá, tình trạng tồn.
SELECT 
    hh.MaHH,
    hh.TenHangHoa,
    lh.TenLoaiHang,
    hh.GiaBan,
    hh.SoLuong AS SoLuongTon,
    CASE
        WHEN hh.SoLuong = 0 THEN 'Hết hàng'
        WHEN hh.SoLuong < 10 THEN 'Sắp hết'
        ELSE 'Còn hàng'
    END AS TinhTrangTon
FROM HangHoa hh
JOIN LoaiHang lh ON hh.MaLoaiHang = lh.MaLoaiHang
WHERE (hh.TenHangHoa LIKE '%sữa%' OR '%sữa%' IS NULL)
   OR (lh.TenLoaiHang LIKE '%đồ uống%' OR '%đồ uống%' IS NULL)
   OR (hh.GiaBan BETWEEN 5000 AND 20000 OR (5000 IS NULL AND 20000 IS NULL))
ORDER BY hh.TenHangHoa;

# Lịch sử nhập hàng Truy vấn: ngày nhập, nhà cung cấp, giá nhập, số lượng.
SELECT 
    pn.MaPhieuNhap,
    pn.NgayNhap,
    ncc.TenNhaCungCap,
    hh.TenHangHoa,
    ctpn.DonGiaNhap,
    ctpn.SoLuongNhap,
    (ctpn.DonGiaNhap * ctpn.SoLuongNhap) AS ThanhTien
FROM PhieuNhap pn
JOIN NhaCungCap ncc ON ncc.MaNhaCungCap = pn.MaNhaCungCap
JOIN ChiTietPhieuNhap ctpn ON ctpn.MaPhieuNhap = pn.MaPhieuNhap
JOIN HangHoa hh ON hh.MaHH = ctpn.MaHH
ORDER BY pn.NgayNhap DESC;

# Lịch sử xuất hàng (bán ra). Truy vấn: ngày bán, khách hàng, sản phẩm, số lượng.
SELECT 
    h.MaHoaDon,
    h.NgayLapHoaDon AS NgayBan,
    kh.TenKhachHang,
    hh.TenHangHoa AS SanPham,
    cthd.SoLuong
FROM HoaDon h
JOIN KhachHang kh ON kh.MaKhachHang = h.MaKhachHang
JOIN ChiTietHoaDon cthd ON cthd.MaHoaDon = h.MaHoaDon
JOIN HangHoa hh ON hh.MaHH = cthd.MaHH
ORDER BY h.NgayLapHoaDon DESC;

# Cảnh báo tồn kho hoặc hết hạn. Truy vấn: sản phẩm có số lượng dưới ngưỡng cảnh báo hoặc sắp hết hạn sử dụng.
-- Tham số cảnh báo
SET @nguong_ton := 50;      -- cảnh báo nếu SoLuong < 50
SET @so_ngay_hsd := 7;      -- cảnh báo nếu HSD trong 7 ngày tới

SELECT
    hh.MaHH,
    hh.TenHangHoa,
    lh.TenLoaiHang,
    hh.SoLuong,
    hh.HSD,
    DATEDIFF(hh.HSD, CURDATE()) AS ConLai_Ngay,
    CASE
        WHEN hh.HSD < CURDATE() THEN 'ĐÃ HẾT HẠN'
        WHEN hh.SoLuong < @nguong_ton AND hh.HSD <= CURDATE() + INTERVAL @so_ngay_hsd DAY THEN 'TỒN THẤP & SẮP HẾT HẠN'
        WHEN hh.SoLuong < @nguong_ton THEN 'TỒN THẤP'
        WHEN hh.HSD <= CURDATE() + INTERVAL @so_ngay_hsd DAY THEN 'SẮP HẾT HẠN'
        ELSE 'Bình thường'
    END AS TrangThaiCanhBao
FROM HangHoa hh
JOIN LoaiHang lh ON lh.MaLoaiHang = hh.MaLoaiHang
WHERE
    hh.SoLuong < @nguong_ton
    OR hh.HSD <= CURDATE() + INTERVAL @so_ngay_hsd DAY
    OR hh.HSD < CURDATE()                -- đã hết hạn (bắt buộc cảnh báo)
ORDER BY
    -- Ưu tiên hiển thị cảnh báo nặng trước
    FIELD(
      CASE
        WHEN hh.HSD < CURDATE() THEN 'ĐÃ HẾT HẠN'
        WHEN hh.SoLuong < @nguong_ton AND hh.HSD <= CURDATE() + INTERVAL @so_ngay_hsd DAY THEN 'TỒN THẤP & SẮP HẾT HẠN'
        WHEN hh.SoLuong < @nguong_ton THEN 'TỒN THẤP'
        WHEN hh.HSD <= CURDATE() + INTERVAL @so_ngay_hsd DAY THEN 'SẮP HẾT HẠN'
        ELSE 'Bình thường'
      END,
      'ĐÃ HẾT HẠN','TỒN THẤP & SẮP HẾT HẠN','TỒN THẤP','SẮP HẾT HẠN','Bình thường'
    ),
    hh.HSD ASC,
    hh.SoLuong ASC;





