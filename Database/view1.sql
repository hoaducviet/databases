-- VIEW danh sách khách hàng và tổng số tiền họ đã chi tiêu
CREATE VIEW CustomerTotalSpent AS
SELECT KhachHang.ID_KH, KhachHang.TenKH, SUM(HoaDon.Tongtien) AS TotalSpent
FROM KhachHang
LEFT JOIN HoaDon ON KhachHang.ID_KH = HoaDon.ID_KH
GROUP BY KhachHang.ID_KH, KhachHang.TenKH;

-- VIEW danh sách nhân viên bán hàng và tổng số hóa đơn mà họ đã tạo
CREATE VIEW SalespersonInvoiceCount AS
SELECT NhanVienBan.ID_NV, NhanVienBan.TenNV, COUNT(HoaDon.ID_HoaDon) AS InvoiceCount
FROM NhanVienBan
LEFT JOIN HoaDon ON NhanVienBan.ID_NV = HoaDon.ID_NV
GROUP BY NhanVienBan.ID_NV, NhanVienBan.TenNV;

-- VIEW danh sách món ăn và tổng số lượng đã bán
CREATE VIEW DishTotalQuantitySold AS
SELECT MonAn.ID_MonAn, MonAn.TenMon, SUM(CTHD.SoLuong) AS TotalQuantitySold
FROM MonAn
LEFT JOIN CTHD ON MonAn.ID_MonAn = CTHD.ID_MonAn
GROUP BY MonAn.ID_MonAn, MonAn.TenMon;

-- VIEW danh sách nguyên liệu và số lượng tồn kho
CREATE VIEW IngredientStock AS
SELECT NguyenLieu.ID_NL, NguyenLieu.TenNL, Kho.SLTon
FROM NguyenLieu
LEFT JOIN Kho ON NguyenLieu.ID_NL = Kho.ID_NL;

-- VIEW danh sách phiếu nhập kho và tổng tiền của từng phiếu
CREATE VIEW ImportOrderTotal AS
SELECT PhieuNK.ID_NK, PhieuNK.NgayNK, SUM(CTNK.Thanhtoan) AS TotalAmount
FROM PhieuNK
LEFT JOIN CTNK ON PhieuNK.ID_NK = CTNK.ID_NK
GROUP BY PhieuNK.ID_NK, PhieuNK.NgayNK;

-- VIEW danh sách phiếu xuất kho và tổng số lượng nguyên liệu đã xuất
CREATE VIEW ExportOrderTotal AS
SELECT PhieuXK.ID_XK, PhieuXK.NgayNK, SUM(CTXK.SoLuong) AS TotalQuantity
FROM PhieuXK
LEFT JOIN CTXK ON PhieuXK.ID_XK = CTXK.ID_XK
GROUP BY PhieuXK.ID_XK, PhieuXK.NgayNK;


-- VIEW danh sách hóa đơn và chi tiết của từng hóa đơn
CREATE VIEW InvoiceDetails AS
SELECT HoaDon.ID_HoaDon, HoaDon.NgayHD, HoaDon.Tongtien, CTHD.ID_MonAn, CTHD.SoLuong, CTHD.ThanhTien
FROM HoaDon
LEFT JOIN CTHD ON HoaDon.ID_HoaDon = CTHD.ID_HoaDon;

-- VIEW danh sách bàn và trạng thái của từng bàn
CREATE VIEW TableStatus AS
SELECT Ban.ID_Ban, Ban.TenBan, Ban.Vitri, Ban.Trangthai
FROM Ban;

-- VIEW danh sách khách hàng và điểm tích lũy của họ
CREATE VIEW CustomerLoyaltyPoints AS
SELECT KhachHang.ID_KH, KhachHang.TenKH, KhachHang.Diemtichluy
FROM KhachHang;

-- VIEW danh sách nhân viên kho và tổng số phiếu nhập kho mà họ đã thực hiện
CREATE VIEW WarehouseStaffImportCount AS
SELECT NhanVienKho.ID_NV, NhanVienKho.TenNV, COUNT(PhieuNK.ID_NK) AS ImportCount
FROM NhanVienKho
LEFT JOIN PhieuNK ON NhanVienKho.ID_NV = PhieuNK.ID_NV
GROUP BY NhanVienKho.ID_NV, NhanVienKho.TenNV;
