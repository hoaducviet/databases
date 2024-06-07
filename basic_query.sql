-- Truy vấn danh sách tất cả các khách hàng và thông tin liên quan đến họ
SELECT *
FROM KhachHang;

-- Truy vấn danh sách các nhân viên bán hàng và thông tin chi tiết của họ
SELECT *
FROM NhanVienBan;

-- Truy vấn thông tin về các hóa đơn, bao gồm tên khách hàng, tên nhân viên bán hàng, tên bàn và thông tin chi tiết hóa đơn
SELECT HoaDon.ID_HoaDon, KhachHang.TenKH, NhanVienBan.TenNV, Ban.TenBan, HoaDon.NgayHD, HoaDon.Tongtien, HoaDon.Trangthai
FROM HoaDon
JOIN KhachHang ON HoaDon.ID_KH = KhachHang.ID_KH
JOIN NhanVienBan ON HoaDon.ID_NV = NhanVienBan.ID_NV
JOIN Ban ON HoaDon.ID_Ban = Ban.ID_Ban;

-- Truy vấn danh sách các món ăn được đặt trong mỗi hóa đơn
SELECT HoaDon.ID_HoaDon, MonAn.TenMon, CTHD.SoLuong, CTHD.ThanhTien
FROM CTHD
JOIN HoaDon ON CTHD.ID_HoaDon = HoaDon.ID_HoaDon
JOIN MonAn ON CTHD.ID_MonAn = MonAn.ID_MonAn;

-- Truy vấn thông tin về các phiếu nhập kho và nhân viên kho liên quan
SELECT PhieuNK.ID_NK, NhanVienKho.TenNV, PhieuNK.NgayNK, PhieuNK.Tongtien
FROM PhieuNK
JOIN NhanVienKho ON PhieuNK.ID_NV = NhanVienKho.ID_NV;

-- Truy vấn thông tin về các phiếu xuất kho và nhân viên kho liên quan
SELECT PhieuXK.ID_XK, NhanVienKho.TenNV, PhieuXK.NgayNK
FROM PhieuXK
JOIN NhanVienKho ON PhieuXK.ID_NV = NhanVienKho.ID_NV;

-- Truy vấn thông tin về các nguyên liệu trong kho
SELECT NguyenLieu.ID_NL, NguyenLieu.TenNL, NguyenLieu.DonGia, NguyenLieu.DonViTinh, Kho.SLTon
FROM NguyenLieu
JOIN Kho ON NguyenLieu.ID_NL = Kho.ID_NL;

-- Truy vấn danh sách tất cả các voucher đang có
SELECT *
FROM Voucher;

-- Truy vấn danh sách các món ăn và đầu bếp của từng món
SELECT MonAn.TenMon, MonAn.DonGia, MonAn.Loai, MonAn.TrangThai, MonAn.DauBep
FROM MonAn;

-- Truy vấn thông tin về các chi tiết nhập kho (CTNK)
SELECT CTNK.ID_NK, PhieuNK.NgayNK, NguyenLieu.TenNL, CTNK.SoLuong, CTNK.Thanhtoan
FROM CTNK
JOIN PhieuNK ON CTNK.ID_NK = PhieuNK.ID_NK
JOIN NguyenLieu ON CTNK.ID_NL = NguyenLieu.ID_NL;

-- Truy vấn thông tin về các chi tiết xuất kho (CTXK)
SELECT CTXK.ID_XK, PhieuXK.NgayNK, NguyenLieu.TenNL, CTXK.SoLuong
FROM CTXK
JOIN PhieuXK ON CTXK.ID_XK = PhieuXK.ID_XK
JOIN NguyenLieu ON CTXK.ID_NL = NguyenLieu.ID_NL;
