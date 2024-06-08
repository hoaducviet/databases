-- Cập nhật số điện thoại của một nhân viên bằng ID_NV
UPDATE NhanVienBan
SET SDT = '0911222333'
WHERE ID_NV = 1;
-- Bạn có thể thay đổi số điện thoại và ID_NV tùy theo nhu cầu.

-- Cập nhật trạng thái của một bàn từ "Trống" thành "Đầy" bằng ID_Ban
UPDATE Ban
SET Trangthai = 'Đầy'
WHERE ID_Ban = 1;
-- Thay đổi ID_Ban để cập nhật trạng thái bàn khác.

-- Thêm một khách hàng mới vào bảng KhachHang
INSERT INTO KhachHang (TenKH, Ngaygiamgia, Doanhso, Diemtichluy)
VALUES ('Nguyễn Văn F', '2024-01-01', 1000000, 50);
-- Thay đổi thông tin khách hàng như tên, ngày giảm giá, doanh số và điểm tích lũy tùy ý.

-- Thêm một nhân viên mới vào bảng NhanVienBan
INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND)
VALUES ('Đặng Thị G', '2024-01-10', '0911223344', 'Bán hàng', 5);
-- Điều chỉnh thông tin nhân viên như tên, ngày vào làm, số điện thoại, chức vụ và ID người dùng.

-- Thêm một món ăn mới vào thực đơn trong bảng MonAn
INSERT INTO MonAn (TenMon, DonGia, Loai, TrangThai, DauBep)
VALUES ('Bún thịt nướng', 35000.00, 'Món chính', 'Còn hàng', 'Nguyễn Văn Chef6');
-- Thay đổi thông tin món ăn như tên, đơn giá, loại, trạng thái và tên đầu bếp.

-- Thêm một voucher mới vào bảng Voucher
INSERT INTO Voucher (Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem)
VALUES ('AUTUMN2024', 'Giảm giá mùa thu 2024', 20.00, 'Tất cả', 150, 20);
-- Thay đổi thông tin voucher như mã, mô tả, phần trăm giảm, loại món ăn, số lượng và điểm.

-- Thêm một phiếu nhập kho mới vào bảng PhieuNK
INSERT INTO PhieuNK (ID_NV, NgayNK, Tongtien)
VALUES (2, '2024-02-01', 800000.00);
-- Điều chỉnh thông tin phiếu nhập kho như ID nhân viên, ngày nhập kho và tổng tiền.

-- Thêm một phiếu xuất kho mới vào bảng PhieuXK
INSERT INTO PhieuXK (ID_NV, NgayNK)
VALUES (2, '2024-02-01');
-- Điều chỉnh thông tin phiếu xuất kho như ID nhân viên và ngày xuất kho.

-- Thêm chi tiết phiếu nhập kho mới vào bảng CTNK
INSERT INTO CTNK (ID_NK, ID_NL, SoLuong, Thanhtoan)
VALUES (1, 1, 50, 500000);
-- Thay đổi thông tin chi tiết phiếu nhập kho như ID phiếu, ID nguyên liệu, số lượng và số tiền thanh toán.

-- Thêm chi tiết phiếu xuất kho mới vào bảng CTXK
INSERT INTO CTXK (ID_XK, ID_NL, SoLuong)
VALUES (1, 1, 30);
-- Thay đổi thông tin chi tiết phiếu xuất kho như ID phiếu, ID nguyên liệu và số lượng.

-- Cập nhật đơn giá của một món ăn trong bảng MonAn
UPDATE MonAn
SET DonGia = 40000.00
WHERE ID_MonAn = 1;
-- Thay đổi ID_MonAn và đơn giá để cập nhật món ăn khác.


-- Xóa thông tin nhân viên khỏi bảng NhanVienBan khi nhân viên nghỉ việc bằng ID_NV
DELETE FROM NhanVienBan
WHERE ID_NV = 1;
-- Thay đổi ID_NV để xóa thông tin nhân viên khác.

-- Xóa thông tin nhân viên khỏi bảng NhanVienKho khi nhân viên nghỉ việc bằng ID_NV
DELETE FROM NhanVienKho
WHERE ID_NV = 1;
-- Thay đổi ID_NV để xóa thông tin nhân viên khác.

-- Cập nhật trạng thái của người dùng khi nhân viên nghỉ việc trong bảng NguoiDung (chuyển trạng thái sang "inactive")
UPDATE NguoiDung
SET Trangthai = 'inactive'
WHERE ID_ND = (SELECT ID_ND FROM NhanVienBan WHERE ID_NV = 1);

UPDATE N
