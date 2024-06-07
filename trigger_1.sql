-- Trigger để tự động cập nhật tổng số tiền đã chi tiêu của khách hàng khi thêm hóa đơn mới
DELIMITER //
CREATE TRIGGER after_insert_hoa_don
AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    UPDATE KhachHang
    SET Doanhso = Doanhso + NEW.Tongtien
    WHERE ID_KH = NEW.ID_KH;
END;
//
DELIMITER ;

-- Trigger để kiểm tra ràng buộc số lượng tồn kho trước khi thêm phiếu xuất kho
DELIMITER //
CREATE TRIGGER before_insert_ctxk
BEFORE INSERT ON CTXK
FOR EACH ROW
BEGIN
    DECLARE sl_ton INT;
    SELECT SLTon INTO sl_ton FROM Kho WHERE ID_NL = NEW.ID_NL;
    IF sl_ton < NEW.SoLuong THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho';
    END IF;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật số lượng tồn kho sau khi thêm phiếu nhập kho
DELIMITER //
CREATE TRIGGER after_insert_ctnk
AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon + NEW.SoLuong
    WHERE ID_NL = NEW.ID_NL;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật số lượng tồn kho sau khi thêm phiếu xuất kho
DELIMITER //
CREATE TRIGGER after_insert_ctxk
AFTER INSERT ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon - NEW.SoLuong
    WHERE ID_NL = NEW.ID_NL;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật điểm tích lũy của khách hàng khi có hóa đơn mới
DELIMITER //
CREATE TRIGGER after_insert_hoa_don_diem_tich_luy
AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    UPDATE KhachHang
    SET Diemtichluy = Diemtichluy + (NEW.Tongtien / 1000)
    WHERE ID_KH = NEW.ID_KH;
END;
//
DELIMITER ;

-- Trigger để kiểm tra và tự động cập nhật trạng thái của bàn khi có thay đổi về hóa đơn
DELIMITER //
CREATE TRIGGER after_insert_hoa_don_ban
AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    UPDATE Ban
    SET Trangthai = 'Đầy'
    WHERE ID_Ban = NEW.ID_Ban;
END;
//
DELIMITER ;

-- Trigger để kiểm tra và tự động cập nhật trạng thái của bàn khi xóa hóa đơn
DELIMITER //
CREATE TRIGGER after_delete_hoa_don_ban
AFTER DELETE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM HoaDon WHERE ID_Ban = OLD.ID_Ban;
    IF total = 0 THEN
        UPDATE Ban
        SET Trangthai = 'Trống'
        WHERE ID_Ban = OLD.ID_Ban;
    END IF;
END;
//
DELIMITER ;

-- Trigger để kiểm tra và tự động cập nhật trạng thái của voucher khi sử dụng
DELIMITER //
CREATE TRIGGER after_insert_hoa_don_voucher
AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Code_Voucher IS NOT NULL THEN
        UPDATE Voucher
        SET SoLuong = SoLuong - 1
        WHERE Code_Voucher = NEW.Code_Voucher;
    END IF;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật thông tin hóa đơn sau khi cập nhật chi tiết hóa đơn
DELIMITER //
CREATE TRIGGER after_update_cthd
AFTER UPDATE ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon
    SET Tongtien = (SELECT SUM(ThanhTien) FROM CTHD WHERE ID_HoaDon = NEW.ID_HoaDon)
    WHERE ID_HoaDon = NEW.ID_HoaDon;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật tổng số lượng trong bảng Kho sau khi cập nhật chi tiết nhập kho
DELIMITER //
CREATE TRIGGER after_update_ctnk
AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon + (NEW.SoLuong - OLD.SoLuong)
    WHERE ID_NL = NEW.ID_NL;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật tổng số lượng trong bảng Kho sau khi cập nhật chi tiết xuất kho
DELIMITER //
CREATE TRIGGER after_update_ctxk
AFTER UPDATE ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon - (NEW.SoLuong - OLD.SoLuong)
    WHERE ID_NL = NEW.ID_NL;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật ThanhTien trong bảng CTNK bằng SoLuong x DonGia của nguyên liệu tương ứng
DELIMITER //
CREATE TRIGGER before_insert_ctnk
BEFORE INSERT ON CTNK
FOR EACH ROW
BEGIN
    DECLARE don_gia DECIMAL(10, 0);
    SELECT DonGia INTO don_gia FROM NguyenLieu WHERE ID_NL = NEW.ID_NL;
    SET NEW.Thanhtoan = NEW.SoLuong * don_gia;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật ThanhTien trong bảng CTNK trước khi cập nhật bằng SoLuong x DonGia của nguyên liệu tương ứng
DELIMITER //
CREATE TRIGGER before_update_ctnk
BEFORE UPDATE ON CTNK
FOR EACH ROW
BEGIN
    DECLARE don_gia DECIMAL(10, 0);
    SELECT DonGia INTO don_gia FROM NguyenLieu WHERE ID_NL = NEW.ID_NL;
    SET NEW.Thanhtoan = NEW.SoLuong * don_gia;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật Tongtien trong bảng PhieuNK sau khi chèn một dòng mới vào CTNK
DELIMITER //
CREATE TRIGGER after_insert_ctnk
AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK
    SET Tongtien = (SELECT SUM(Thanhtoan) FROM CTNK WHERE ID_NK = NEW.ID_NK)
    WHERE ID_NK = NEW.ID_NK;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật Tongtien trong bảng PhieuNK sau khi cập nhật một dòng trong CTNK
DELIMITER //
CREATE TRIGGER after_update_ctnk
AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK
    SET Tongtien = (SELECT SUM(Thanhtoan) FROM CTNK WHERE ID_NK = NEW.ID_NK)
    WHERE ID_NK = NEW.ID_NK;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật Tongtien trong bảng PhieuNK sau khi xóa một dòng trong CTNK
DELIMITER //
CREATE TRIGGER after_delete_ctnk
AFTER DELETE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK
    SET Tongtien = (SELECT SUM(Thanhtoan) FROM CTNK WHERE ID_NK = OLD.ID_NK)
    WHERE ID_NK = OLD.ID_NK;
END;
//
DELIMITER ;

-- Trigger để tự động thêm nguyên liệu mới vào bảng Kho khi một nguyên liệu mới được thêm vào bảng NguyenLieu
DELIMITER //
CREATE TRIGGER after_insert_nguyen_lieu
AFTER INSERT ON NguyenLieu
FOR EACH ROW
BEGIN
    INSERT INTO Kho (ID_NL, SLTon)
    VALUES (NEW.ID_NL, 0);
END;
//
DELIMITER ;

-- Trigger để tính ThanhTien trong bảng CTHD bằng SoLuong x DonGia của món ăn tương ứng
DELIMITER //
CREATE TRIGGER before_insert_or_update_cthd
BEFORE INSERT OR UPDATE ON CTHD
FOR EACH ROW
BEGIN
    DECLARE gia DECIMAL(10, 0);
    SELECT DonGia INTO gia FROM MonAn WHERE MonAn.ID_MonAn = NEW.ID_MonAn;
    SET NEW.ThanhTien = NEW.SoLuong * gia;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật TienMonAn trong bảng HoaDon bằng tổng ThanhTien của các món ăn trong CTHD
DELIMITER //
CREATE TRIGGER after_insert_update_delete_cthd
AFTER INSERT OR UPDATE OR DELETE ON CTHD
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE HoaDon 
        SET TienMonAn = TienMonAn + NEW.ThanhTien 
        WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
    END IF;

    IF UPDATING THEN
        UPDATE HoaDon 
        SET TienMonAn = TienMonAn + NEW.ThanhTien - OLD.ThanhTien 
        WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
    END IF;

    IF DELETING THEN
        UPDATE HoaDon 
        SET TienMonAn = TienMonAn - OLD.ThanhTien 
        WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
    END IF;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật TienGiam trong bảng HoaDon dựa trên tổng ThanhTien của các món ăn được giảm và phần trăm giảm giá
DELIMITER //
CREATE TRIGGER after_insert_update_delete_cthd_voucher
AFTER INSERT OR UPDATE OR DELETE ON CTHD
FOR EACH ROW
BEGIN
    DECLARE v_code VARCHAR(210);
    DECLARE v_phantram DECIMAL(3, 0);
    DECLARE v_loaiMA VARCHAR(250);
    DECLARE ma_loai VARCHAR(250);

    IF INSERTING OR UPDATING THEN
        SELECT HoaDon.Code_Voucher, Voucher.Phantram, Voucher.LoaiMA 
        INTO v_code, v_phantram, v_loaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;

        SELECT Loai INTO ma_loai
        FROM MonAn
        WHERE MonAn.ID_MonAn = NEW.ID_MonAn;
    END IF;

    IF DELETING THEN
        SELECT HoaDon.Code_Voucher, Voucher.Phantram, Voucher.LoaiMA 
        INTO v_code, v_phantram, v_loaiMA
        FROM HoaDon
        LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;

        SELECT Loai INTO ma_loai
        FROM MonAn
        WHERE MonAn.ID_MonAn = OLD.ID_MonAn;
    END IF;

    IF v_code IS NOT NULL THEN
        IF v_loaiMA = 'All' OR v_loaiMA = ma_loai THEN
            IF INSERTING THEN
                UPDATE HoaDon 
                SET TienGiam = TienGiam + (NEW.ThanhTien * v_phantram / 100) 
                WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
            END IF;

            IF UPDATING THEN
                UPDATE HoaDon 
                SET TienGiam = TienGiam + (NEW.ThanhTien * v_phantram / 100) - (OLD.ThanhTien * v_phantram / 100) 
                WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
            END IF;

            IF DELETING THEN
                UPDATE HoaDon 
                SET TienGiam = TienGiam - (OLD.ThanhTien * v_phantram / 100) 
                WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
            END IF;
        END IF;
    END IF;
END;
//
DELIMITER ;

-- Trigger để tự động cập nhật Tongtien trong bảng HoaDon bằng TienMonAn - TienGiam
DELIMITER //
CREATE TRIGGER after_update_tienmonan_tiengiam
AFTER UPDATE OF TienMonAn, TienGiam ON HoaDon
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET Tongtien = NEW.TienMonAn - NEW.TienGiam 
    WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
END;
//
DELIMITER ;
