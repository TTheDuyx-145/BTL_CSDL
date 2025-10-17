USE QLCH;
-- I.
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

-- II.
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

-- III. Phân hệ báo cáo và thống kê --
-- 1. Truy vấn tổng doanh thu theo ngày, tháng --
SELECT 
	distinct hd.NgayLapHoaDon, 
    SUM(ct.ThanhTien) OVER (PARTITION BY hd.NgayLapHoaDon) AS TongTheoNgay
FROM ChiTietHoaDon ct
JOIN HoaDon hd
ON ct.MaHoaDon = hd.MaHoaDon
order by hd.NgayLapHoaDon;
-- Truy vấn tổng doanh thu theo tháng --
SELECT 
	distinct hd.NgayLapHoaDon, 
    SUM(ct.ThanhTien) OVER (PARTITION BY YEAR(hd.NgayLapHoaDon), MONTH(hd.NgayLapHoaDon)) AS TongTheoThang
FROM ChiTietHoaDon ct
JOIN HoaDon hd
ON ct.MaHoaDon = hd.MaHoaDon
order by hd.NgayLapHoaDon;

-- 2. Doanh thu theo nhân viên trong năm nay --
SELECT 
	distinct nv.HoVaTen,
    SUM(ct.ThanhTien) OVER (PARTITION BY YEAR(hd.NgayLapHoaDon), nv.HoVaTen) AS TongTheoNam
FROM ChiTietHoaDon ct
JOIN HoaDon hd
ON ct.MaHoaDon = hd.MaHoaDon
JOIN NhanVien nv
on nv.MaNhanVien = hd.MaNhanVien
WHERE YEAR(hd.NgayLapHoaDon) = YEAR(current_date())
order by TongTheoNam;

-- 3. Doanh thu theo loại hàng --
SELECT 
	distinct hh.TenHangHoa,
    pn.DonGiaNhap as GiaNhap,
    hh.GiaBan as GiaXuat,
    (hh.GiaBan - pn.DonGiaNhap) as LoiNhuan
FROM ChiTietPhieuNhap pn
JOIN HangHoa hh
ON pn.MaHH= hh.MaHH
order by LoiNhuan desc;

-- 4. Doanh thu xếp theo sản phẩm bán chạy/bán chậm --
SELECT 
	distinct hh.TenHangHoa,
    SUM(px.SoLuongXuat) OVER (PARTITION BY(px.MaHH)) AS SoLuongDaBan
FROM HangHoa hh
JOIN ChiTietPhieuXuat px
ON hh.MaHH = px.MaHH
ORDER BY SoLuongDaBan DESC;

-- 5. Giá trị tồn kho --
SELECT
	distinct TenHangHoa,
    SoLuong,
    GiaBan,
    (SoLuong*GiaBan) TongGiaTri
FROM HangHoa;
    
-- 6. Báo cáo tổng hợp --
SELECT
    DATE(hd.NgayLapHoaDon) AS Ngay,

    -- Doanh thu mỗi ngày
    SUM(cthd.ThanhTien) AS DoanhThu,

    -- Số hóa đơn mỗi ngày
    COUNT(DISTINCT hd.MaHoaDon) AS SoHoaDon,

    -- Số khách hàng khác nhau trong ngày
    COUNT(DISTINCT hd.MaKhachHang) AS SoKhachHang,

    -- Số sản phẩm dưới 20 (không phụ thuộc ngày)
    (SELECT COUNT(*) FROM HangHoa WHERE SoLuong < 100) AS SoSanPhamSapHet
FROM HoaDon hd
JOIN ChiTietHoaDon cthd
    ON cthd.MaHoaDon = hd.MaHoaDon
GROUP BY DATE(hd.NgayLapHoaDon)
ORDER BY Ngay;



-- IV. Phân hệ quản lí danh mục --
-- 1. Danh sách nhân viên --
SELECT
	nv.HoVaTen,
    nv.GioiTinh,
    cv.TenChucVu,
    nv.SoDienThoai
FROM NhanVien nv
JOIN ChucVu cv
ON nv.MaChucVu = cv.MaChucVu;

-- 2. Lịch sử bán hàng của nhân viên --
SELECT * FROM hoadon;
SELECT 
    nv.HoVaTen,
    COUNT(distinct hd.MaHoaDon) AS TongHoaDon, -- có distinct vì 1 mã hóa đơn có nhiều loại hàng, gây ra lặp thông tin --
    SUM(cthd.ThanhTien) AS TongDoanhThu
FROM ChiTietHoaDon cthd
JOIN HoaDon hd
    ON cthd.MaHoaDon = hd.MaHoaDon
JOIN NhanVien nv
    ON nv.MaNhanVien = hd.MaNhanVien
GROUP BY nv.HoVaTen
ORDER BY TongDoanhThu DESC;

-- 3. Danh sách khách hàng --
 SELECT 
    kh.*,
    CASE
        WHEN tv.MaKhachHang IS NOT NULL THEN 'Thành viên'
        WHEN vip.MaKhachHang IS NOT NULL THEN 'VIP'
        ELSE 'Thường'
    END AS LoaiKhach
FROM KhachHang kh
LEFT JOIN khachhang_thanhvien tv 
    ON kh.MaKhachHang = tv.MaKhachHang
LEFT JOIN khachhang_vip vip
    ON kh.MaKhachHang = vip.MaKhachHang;

-- 4. Lịch sử mua hàng theo khách hàng --
SELECT 
    kh.TenKhachHang,
    hh.TenHangHoa,
    SUM(cthd.ThanhTien) AS TongTien,
    MAX(hd.NgayLapHoaDon) AS NgayMuaGanNhat
FROM ChiTietHoaDon cthd
JOIN HangHoa hh
    ON cthd.MaHH = hh.MaHH
JOIN HoaDon hd
    ON hd.MaHoaDon = cthd.MaHoaDon
JOIN KhachHang kh
    ON kh.MaKhachHang = hd.MaKhachHang
GROUP BY kh.TenKhachHang, hh.TenHangHoa
ORDER BY kh.TenKhachHang, NgayMuaGanNhat DESC;

-- 5. Danh sách nhà cung cấp --
SELECT 
	ncc.TenNhaCungCap,
    ncc.DiaChi,
    ncc.SoDienThoai,
    lh.NgayNhap
FROM nhacungcap ncc
JOIN hopdong hd
	ON ncc.MaNhaCungCap = hd.MaNhaCungCap
JOIN LoHang lh
	ON hd.MaHopDong = lh.MaHopDong;
    
-- 6. Loại Hàng Hóa --
SELECT 
	distinct lh.MaLoaiHang,
	lh.TenLoaiHang,
    COUNT(hh.MaLoaiHang) OVER (partition by hh.MaLoaiHang) SoLuongSanPhamTheoLoai,
    SUM(hh.GiaBan) OVER (partition by hh.MaLoaiHang) TongDoanhThuLoaiHang
FROM HangHoa hh
JOIN LoaiHang lh
	ON hh.MaLoaiHang = lh.MaLoaiHang
;



