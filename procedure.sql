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

-- Thủ tục để tính tổng số tiền đã chi tiêu của một khách hàng
DELIMITER //
CREATE PROCEDURE GetTotalSpent(
    IN p_ID_KH INT,
    OUT p_TotalSpent DECIMAL(10,0)
)
BEGIN
    SELECT SUM(Tongtien)
    INTO p_TotalSpent
    FROM HoaDon
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
