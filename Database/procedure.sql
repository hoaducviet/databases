-- Thủ tục để thêm một khách hàng mới
DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN p_TenKH VARCHAR(250),
    IN p_Ngaythamgia DATE,
    IN p_Doanhso DECIMAL(10,0),
    IN p_Diemtichluy DECIMAL(5,0)
)
BEGIN
    INSERT INTO KhachHang (TenKH, Ngaythamgia, Doanhso, Diemtichluy)
    VALUES (p_TenKH, p_Ngaythamgia, p_Doanhso, p_Diemtichluy);
END;
//
DELIMITER ;

-- Thủ tục để cập nhật thông tin khách hàng
DELIMITER //
CREATE PROCEDURE UpdateCustomer(
    IN p_ID_KH INT,
    IN p_TenKH VARCHAR(250),
    IN p_Ngaythamgia DATE,
    IN p_Doanhso DECIMAL(10,0),
    IN p_Diemtichluy DECIMAL(5,0)
)
BEGIN
    UPDATE KhachHang
    SET TenKH = p_TenKH,
        Ngaythamgia = p_Ngaythamgia,
        Doanhso = p_Doanhso,
        Diemtichluy = p_Diemtichluy
    WHERE ID_KH = p_ID_KH;
END;
//
DELIMITER ;

-- Thủ tục để xóa một khách hàng
DELIMITER //
CREATE PROCEDURE DeleteCustomer(
    IN p_ID_KH INT
)
BEGIN
    DELETE FROM KhachHang
    WHERE ID_KH = p_ID_KH;
END;
//
DELIMITER ;

-- Thủ tục để thêm một món ăn mới vào thực đơn
DELIMITER //
CREATE PROCEDURE AddDish(
    IN p_TenMon VARCHAR(250),
    IN p_DonGia DECIMAL(10,0),
    IN p_Loai VARCHAR(250),
    IN p_TrangThai VARCHAR(250),
    IN p_DauBep VARCHAR(250)
)
BEGIN
    INSERT INTO MonAn (TenMon, DonGia, Loai, TrangThai, DauBep)
    VALUES (p_TenMon, p_DonGia, p_Loai, p_TrangThai, p_DauBep);
END;
//
DELIMITER ;

-- Thủ tục để cập nhật thông tin món ăn
DELIMITER //
CREATE PROCEDURE UpdateDish(
    IN p_ID_MonAn INT,
    IN p_TenMon VARCHAR(250),
    IN p_DonGia DECIMAL(10,0),
    IN p_Loai VARCHAR(250),
    IN p_TrangThai VARCHAR(250),
    IN p_DauBep VARCHAR(250)
)
BEGIN
    UPDATE MonAn
    SET TenMon = p_TenMon,
        DonGia = p_DonGia,
        Loai = p_Loai,
        TrangThai = p_TrangThai,
        DauBep = p_DauBep
    WHERE ID_MonAn = p_ID_MonAn;
END;
//
DELIMITER ;

-- Thủ tục để xóa một món ăn
DELIMITER //
CREATE PROCEDURE DeleteDish(
    IN p_ID_MonAn INT
)
BEGIN
    DELETE FROM MonAn
    WHERE ID_MonAn = p_ID_MonAn;
END;
//
DELIMITER ;

-- Thủ tục để thêm một nhân viên mới vào bảng NhanVienBan
DELIMITER //
CREATE PROCEDURE AddSalesperson(
    IN p_TenNV VARCHAR(250),
    IN p_NgayVL DATE,
    IN p_SDT VARCHAR(250),
    IN p_Chucvu VARCHAR(250),
    IN p_ID_ND INT
)
BEGIN
    INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND)
    VALUES (p_TenNV, p_NgayVL, p_SDT, p_Chucvu, p_ID_ND);
END;
//
DELIMITER ;

-- Thủ tục để cập nhật thông tin nhân viên bán hàng
DELIMITER //
CREATE PROCEDURE UpdateSalesperson(
    IN p_ID_NV INT,
    IN p_TenNV VARCHAR(250),
    IN p_NgayVL DATE,
    IN p_SDT VARCHAR(250),
    IN p_Chucvu VARCHAR(250)
)
BEGIN
    UPDATE NhanVienBan
    SET TenNV = p_TenNV,
        NgayVL = p_NgayVL,
        SDT = p_SDT,
        Chucvu = p_Chucvu
    WHERE ID_NV = p_ID_NV;
END;
//
DELIMITER ;

-- Thủ tục để xóa một nhân viên bán hàng
DELIMITER //
CREATE PROCEDURE DeleteSalesperson(
    IN p_ID_NV INT
)
BEGIN
    DELETE FROM NhanVienBan
    WHERE ID_NV = p_ID_NV;
END;
//
DELIMITER ;

-- Thủ tục để lấy thông tin chi tiết của hóa đơn
DELIMITER //
CREATE PROCEDURE GetInvoiceDetails(
    IN p_ID_HoaDon INT
)
BEGIN
    SELECT *
    FROM CTHD
    WHERE ID_HoaDon = p_ID_HoaDon;
END;
//
DELIMITER ;
