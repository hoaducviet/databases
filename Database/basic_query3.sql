-- 1. Truy vấn danh sách khách hàng và số lượng hóa đơn của mỗi khách hàng
SELECT KhachHang.ID_KH, KhachHang.TenKH, COUNT(HoaDon.ID_HoaDon) AS SoLuongHoaDon
FROM KhachHang
LEFT JOIN HoaDon ON KhachHang.ID_KH = HoaDon.ID_KH
GROUP BY KhachHang.ID_KH, KhachHang.TenKH;

-- 2. Truy vấn danh sách nhân viên kho và tổng số lượng phiếu nhập kho họ đã thực hiện
SELECT NhanVienKho.ID_NV, NhanVienKho.TenNV, COUNT(PhieuNK.ID_NK) AS SoLuongPhieuNK
FROM NhanVienKho
LEFT JOIN PhieuNK ON NhanVienKho.ID_NV = PhieuNK.ID_NV
GROUP BY NhanVienKho.ID_NV, NhanVienKho.TenNV;

-- 3. Truy vấn danh sách các món ăn được đặt trong mỗi hóa đơn
SELECT HoaDon.ID_HoaDon, CTHD.ID_MonAn, MonAn.TenMon, CTHD.SoLuong, CTHD.ThanhTien
FROM HoaDon
LEFT JOIN CTHD ON HoaDon.ID_HoaDon = CTHD.ID_HoaDon
LEFT JOIN MonAn ON CTHD.ID_MonAn = MonAn.ID_MonAn;

-- 4. Truy vấn danh sách các phiếu xuất kho và tổng giá trị của từng phiếu
SELECT PhieuXK.ID_XK, PhieuXK.NgayNK, SUM(CTXK.SoLuong * NguyenLieu.DonGia) AS TongGiaTri
FROM PhieuXK
LEFT JOIN CTXK ON PhieuXK.ID_XK = CTXK.ID_XK
LEFT JOIN NguyenLieu ON CTXK.ID_NL = NguyenLieu.ID_NL
GROUP BY PhieuXK.ID_XK, PhieuXK.NgayNK;

-- 5. Truy vấn danh sách các voucher và số lượng còn lại
SELECT Voucher.Code_Voucher, Voucher.Mota, Voucher.Phantram, Voucher.SoLuong
FROM Voucher;

-- 6. Truy vấn danh sách các bàn và trạng thái hiện tại
SELECT Ban.ID_Ban, Ban.TenBan, Ban.Vitri, Ban.Trangthai
FROM Ban;

-- 7. Truy vấn danh sách các nguyên liệu và số lượng tồn kho
SELECT NguyenLieu.ID_NL, NguyenLieu.TenNL, Kho.SLTon
FROM NguyenLieu
LEFT JOIN Kho ON NguyenLieu.ID_NL = Kho.ID_NL;

-- 8. Truy vấn danh sách các hóa đơn và tổng tiền
SELECT HoaDon.ID_HoaDon, HoaDon.NgayHD, HoaDon.Tongtien
FROM HoaDon;

-- 9. Truy vấn danh sách nhân viên và số lượng phiếu xuất kho họ đã thực hiện
SELECT NhanVienKho.ID_NV, NhanVienKho.TenNV, COUNT(PhieuXK.ID_XK) AS SoLuongPhieuXK
FROM NhanVienKho
LEFT JOIN PhieuXK ON NhanVienKho.ID_NV = PhieuXK.ID_NV
GROUP BY NhanVienKho.ID_NV, NhanVienKho.TenNV;

-- 10. Truy vấn danh sách khách hàng và điểm tích lũy của họ
SELECT KhachHang.ID_KH, KhachHang.TenKH, KhachHang.Diemtichluy
FROM KhachHang;

-- 11. Truy vấn danh sách các món ăn và tổng số lượng đã bán
SELECT MonAn.ID_MonAn, MonAn.TenMon, SUM(CTHD.SoLuong) AS TongSoLuong
FROM MonAn
LEFT JOIN CTHD ON MonAn.ID_MonAn = CTHD.ID_MonAn
GROUP BY MonAn.ID_MonAn, MonAn.TenMon;

-- 12. Truy vấn danh sách các nguyên liệu và tổng giá trị tồn kho
SELECT NguyenLieu.ID_NL, NguyenLieu.TenNL, (Kho.SLTon * NguyenLieu.DonGia) AS TongGiaTriTonKho
FROM NguyenLieu
LEFT JOIN Kho ON NguyenLieu.ID_NL = Kho.ID_NL;

-- 13. Truy vấn danh sách các hóa đơn và tổng tiền giảm giá
SELECT HoaDon.ID_HoaDon, HoaDon.Tongtien, HoaDon.TienGiam
FROM HoaDon;

-- 14. Truy vấn danh sách các bàn có trạng thái 'Đầy'
SELECT Ban.ID_Ban, Ban.TenBan, Ban.Vitri
FROM Ban
WHERE Ban.Trangthai = 'Đầy';

-- 15. Truy vấn danh sách nhân viên và số lượng hóa đơn họ đã tạo
SELECT NhanVienBan.ID_NV, NhanVienBan.TenNV, COUNT(HoaDon.ID_HoaDon) AS SoLuongHoaDon
FROM NhanVienBan
LEFT JOIN HoaDon ON NhanVienBan.ID_NV = HoaDon.ID_NV
GROUP BY NhanVienBan.ID_NV, NhanVienBan.TenNV;
