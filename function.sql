-- Hàm tính tổng số lượng món ăn đã bán của một món ăn cụ thể
DELIMITER //
CREATE FUNCTION GetTotalQuantitySold(p_ID_MonAn INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_quantity INT;
    SELECT SUM(SoLuong) INTO total_quantity
    FROM CTHD
    WHERE ID_MonAn = p_ID_MonAn;
    RETURN total_quantity;
END;
//
DELIMITER ;

-- Hàm tính tổng doanh thu của một món ăn cụ thể
DELIMITER //
CREATE FUNCTION GetTotalRevenue(p_ID_MonAn INT) RETURNS DECIMAL(10,0)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_revenue DECIMAL(10,0);
    SELECT SUM(ThanhTien) INTO total_revenue
    FROM CTHD
    WHERE ID_MonAn = p_ID_MonAn;
    RETURN total_revenue;
END;
//
DELIMITER ;

-- Hàm lấy tên khách hàng dựa trên ID khách hàng
DELIMITER //
CREATE FUNCTION GetCustomerName(p_ID_KH INT) RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE customer_name VARCHAR(250);
    SELECT TenKH INTO customer_name
    FROM KhachHang
    WHERE ID_KH = p_ID_KH;
    RETURN customer_name;
END;
//
DELIMITER ;

-- Hàm lấy số điện thoại của nhân viên bán hàng dựa trên ID nhân viên
DELIMITER //
CREATE FUNCTION GetSalespersonPhone(p_ID_NV INT) RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE phone_number VARCHAR(250);
    SELECT SDT INTO phone_number
    FROM NhanVienBan
    WHERE ID_NV = p_ID_NV;
    RETURN phone_number;
END;
//
DELIMITER ;

-- Hàm tính tổng số phiếu nhập kho của một nhân viên kho cụ thể
DELIMITER //
CREATE FUNCTION GetTotalImportOrders(p_ID_NV INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_orders INT;
    SELECT COUNT(*) INTO total_orders
    FROM PhieuNK
    WHERE ID_NV = p_ID_NV;
    RETURN total_orders;
END;
//
DELIMITER ;

-- Hàm lấy vị trí của bàn dựa trên ID bàn
DELIMITER //
CREATE FUNCTION GetTableLocation(p_ID_Ban INT) RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE location VARCHAR(250);
    SELECT Vitri INTO location
    FROM Ban
    WHERE ID_Ban = p_ID_Ban;
    RETURN location;
END;
//
DELIMITER ;

-- Hàm tính tổng số lượng nguyên liệu tồn kho
DELIMITER //
CREATE FUNCTION GetTotalStock() RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_stock INT;
    SELECT SUM(SLTon) INTO total_stock
    FROM Kho;
    RETURN total_stock;
END;
//
DELIMITER ;

-- Hàm lấy tên đầu bếp của món ăn dựa trên ID món ăn
DELIMITER //
CREATE FUNCTION GetChefName(p_ID_MonAn INT) RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE chef_name VARCHAR(250);
    SELECT DauBep INTO chef_name
    FROM MonAn
    WHERE ID_MonAn = p_ID_MonAn;
    RETURN chef_name;
END;
//
DELIMITER ;

-- Hàm tính tổng giá trị giảm giá của một hóa đơn
DELIMITER //
CREATE FUNCTION GetTotalDiscount(p_ID_HoaDon INT) RETURNS DECIMAL(10,0)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_discount DECIMAL(10,0);
    SELECT TienGiam INTO total_discount
    FROM HoaDon
    WHERE ID_HoaDon = p_ID_HoaDon;
    RETURN total_discount;
END;
//
DELIMITER ;

-- Hàm lấy tên nguyên liệu dựa trên ID nguyên liệu
DELIMITER //
CREATE FUNCTION GetIngredientName(p_ID_NL INT) RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ingredient_name VARCHAR(250);
    SELECT TenNL INTO ingredient_name
    FROM NguyenLieu
    WHERE ID_NL = p_ID_NL;
    RETURN ingredient_name;
END;
//
DELIMITER ;
