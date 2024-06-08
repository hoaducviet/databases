-- Truy vấn thông tin hóa đơn bao gồm chi tiết món ăn, tổng số lượng và tổng tiền cho từng hóa đơn
SELECT HoaDon.ID_HoaDon, KhachHang.TenKH, HoaDon.NgayHD, SUM(CTHD.SoLuong) AS TongSoLuong, SUM(CTHD.ThanhTien) AS TongTien
FROM HoaDon
JOIN KhachHang ON HoaDon.ID_KH = KhachHang.ID_KH
JOIN CTHD ON HoaDon.ID_HoaDon = CTHD.ID_HoaDon
GROUP BY HoaDon.ID_HoaDon, KhachHang.TenKH, HoaDon.NgayHD;

-- Truy vấn danh sách các nhân viên và tổng số phiếu nhập kho mà họ đã thực hiện
SELECT NhanVienKho.TenNV, COUNT(PhieuNK.ID_NK) AS TongSoPhieuNK
FROM NhanVienKho
JOIN PhieuNK ON NhanVienKho.ID_NV = PhieuNK.ID_NV
GROUP BY NhanVienKho.TenNV
HAVING COUNT(PhieuNK.ID_NK) > 0;

-- Truy vấn danh sách các món ăn kèm theo số lượng đã bán được trong tất cả các hóa đơn
SELECT MonAn.TenMon, SUM(CTHD.SoLuong) AS SoLuongDaBan
FROM MonAn
JOIN CTHD ON MonAn.ID_MonAn = CTHD.ID_MonAn
GROUP BY MonAn.TenMon
ORDER BY SoLuongDaBan DESC;

-- Truy vấn thông tin về các phiếu nhập kho và chi tiết nguyên liệu nhập trong khoảng thời gian nhất định
SELECT PhieuNK.ID_NK, PhieuNK.NgayNK, NguyenLieu.TenNL, CTNK.SoLuong, CTNK.Thanhtoan
FROM PhieuNK
JOIN CTNK ON PhieuNK.ID_NK = CTNK.ID_NK
JOIN NguyenLieu ON CTNK.ID_NL = NguyenLieu.ID_NL
WHERE PhieuNK.NgayNK BETWEEN '2022-01-01' AND '2024-12-31';

-- Truy vấn danh sách các khách hàng kèm theo tổng số tiền họ đã chi tiêu
SELECT KhachHang.TenKH, SUM(HoaDon.Tongtien) AS TongTienDaChi
FROM KhachHang
JOIN HoaDon ON KhachHang.ID_KH = HoaDon.ID_KH
GROUP BY KhachHang.TenKH
ORDER BY TongTienDaChi DESC;

-- Truy vấn thông tin về các món ăn được đặt nhiều nhất trong một khoảng thời gian
SELECT MonAn.TenMon, SUM(CTHD.SoLuong) AS SoLuongDaDat
FROM MonAn
JOIN CTHD ON MonAn.ID_MonAn = CTHD.ID_MonAn
JOIN HoaDon ON CTHD.ID_HoaDon = HoaDon.ID_HoaDon
WHERE HoaDon.NgayHD BETWEEN '2022-01-01' AND '2024-12-31'
GROUP BY MonAn.TenMon
ORDER BY SoLuongDaDat DESC;

-- Truy vấn danh sách các nhân viên và số phiếu xuất kho họ đã thực hiện trong năm 2023, 2024
SELECT NhanVienKho.TenNV, COUNT(PhieuXK.ID_XK) AS TongSoPhieuXK
FROM NhanVienKho
JOIN PhieuXK ON NhanVienKho.ID_NV = PhieuXK.ID_NV
WHERE PhieuXK.NgayNK BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY NhanVienKho.TenNV;

-- Truy vấn thông tin về các bàn có số hóa đơn lớn nhất trong một khoảng thời gian nhất định
SELECT Ban.TenBan, COUNT(HoaDon.ID_HoaDon) AS SoHoaDon
FROM Ban
JOIN HoaDon ON Ban.ID_Ban = HoaDon.ID_Ban
WHERE HoaDon.NgayHD BETWEEN '2022-01-01' AND '2024-12-31'
GROUP BY Ban.TenBan
ORDER BY SoHoaDon DESC;

-- Truy vấn thông tin về các phiếu nhập kho kèm chi tiết nguyên liệu được nhập nhiều nhất
SELECT PhieuNK.ID_NK, PhieuNK.NgayNK, NguyenLieu.TenNL, MAX(CTNK.SoLuong) AS SoLuongLonNhat
FROM PhieuNK
JOIN CTNK ON PhieuNK.ID_NK = CTNK.ID_NK
JOIN NguyenLieu ON CTNK.ID_NL = NguyenLieu.ID_NL
GROUP BY PhieuNK.ID_NK, PhieuNK.NgayNK, NguyenLieu.TenNL;

-- Truy vấn thông tin về các khách hàng đã sử dụng voucher nhiều nhất
SELECT KhachHang.TenKH, COUNT(HoaDon.Code_Voucher) AS SoLanSuDungVoucher
FROM KhachHang
JOIN HoaDon ON KhachHang.ID_KH = HoaDon.ID_KH
WHERE HoaDon.Code_Voucher IS NOT NULL
GROUP BY KhachHang.TenKH
ORDER BY SoLanSuDungVoucher DESC;
