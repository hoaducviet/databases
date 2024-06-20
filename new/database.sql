DROP DATABASE IF EXISTS mysql_res;
CREATE DATABASE mysql_res;
use mysql_res;

CREATE TABLE KhachHang (
    ID_KH INT auto_increment,
    TenKH VARCHAR(250) not null,
    SDT VARCHAR(11) UNIQUE,
    Ngaythamgia DATE,
    Doanhso DECIMAL(10,0) DEFAULT 0,
    Diemtichluy DECIMAL(5,0) DEFAULT 0,
    PRIMARY KEY (ID_KH)
);


CREATE TABLE NguoiDung (
    ID_ND INT auto_increment,
    Email VARCHAR(250) not null,
    Matkhau VARCHAR(250) not null,
    VerifyCode VARCHAR(210),
    Trangthai VARCHAR(210) not null DEFAULT "Active",
    Vaitro VARCHAR(220) not null,
    PRIMARY KEY (ID_ND),
    UNIQUE (Email),
    CHECK (Vaitro in ('Nhân viên bàn', 'Nhân viên kho')),
    CHECK (Trangthai in ('InActive', 'Active'))
);



CREATE TABLE NhanVienKho (
    ID_NV INT auto_increment,
    TenNV VARCHAR(250) not null,
    NgayVL DATE,
    SDT VARCHAR(250) unique not null,
    Chucvu VARCHAR(250) not null,
    ID_ND INT not null,
    ID_NQL INT NULL,
    PRIMARY KEY (ID_NV),
    FOREIGN KEY (ID_NQL) REFERENCES NhanVienKho(ID_NV),
    FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND),
    CHECK (Chucvu in ('Nhân viên', 'Quản lý'))
);

CREATE TABLE NhanVienBan (
    ID_NV INT auto_increment,
    TenNV VARCHAR(250) not null,
    NgayVL DATE,
    SDT VARCHAR(250) unique not null,
    Chucvu VARCHAR(250) not null,
    ID_ND INT not null,
    ID_NQL INT NULL,
    PRIMARY KEY (ID_NV),
    FOREIGN KEY (ID_NQL) REFERENCES NhanVienBan(ID_NV),
    FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND),
    CHECK (Chucvu in ('Phục vụ', 'Thu ngân', 'Quản lý'))
);



CREATE TABLE Ban (
    ID_Ban INT auto_increment,
    TenBan VARCHAR(250),
    ViTri VARCHAR(250),
    TrangThai VARCHAR(250) DEFAULT 'Trống',
    PRIMARY KEY (ID_Ban),
    CHECK (TrangThai in ('Trống', 'Đã đặt', 'Đang sử dụng'))
);


CREATE TABLE Voucher (
    Code_Voucher VARCHAR(210),
    Mota VARCHAR(250),
    Phantram DECIMAL(3,0),
    LoaiMA VARCHAR(250),
    SoLuong INT,
    Diem DECIMAL(10,0),
    PRIMARY KEY (Code_Voucher)
);


CREATE TABLE HoaDon (
    ID_HoaDon INT auto_increment,
    ID_NV INT not null,
    ID_KH INT,
    ID_Ban INT not null,
    NgayHD DATETIME null,
    Code_Voucher VARCHAR(210),
    TienMonAn DECIMAL(10,0) DEFAULT 0,
    TienGiam DECIMAL(10,0) DEFAULT 0,
    TongTien DECIMAL(10,0) DEFAULT 0,
    TrangThai VARCHAR(250) DEFAULT 'Chưa thanh toán',
    PRIMARY KEY (ID_HoaDon),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienBan(ID_NV),
    FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH),
    FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban),
    FOREIGN KEY (Code_Voucher) REFERENCES Voucher(Code_Voucher),
    CHECK (Trangthai in ('Chưa thanh toán', 'Đã thanh toán'))
);

CREATE TABLE MonAn (
    ID_MonAn INT auto_increment,
    TenMon VARCHAR(250) not null,
    DonGia DECIMAL(10,0) not null,
    Loai VARCHAR(250) not null,
    TrangThai VARCHAR(250),
    DauBep VARCHAR(250),
    DanhGia DECIMAL(10,2),
    ImageUrl VARCHAR(250) null,
    PRIMARY KEY (ID_MonAn)
);

CREATE TABLE CTHD (
    ID_HoaDon INT not null,
    ID_MonAn INT not null,
    SoLuong INT not null,
    ThanhTien DECIMAL(10,0),
    PRIMARY KEY (ID_HoaDon, ID_MonAn),
    FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon),
    FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn)
);



CREATE TABLE NguyenLieu (
    ID_NL INT auto_increment,
    TenNL VARCHAR(250) not null,
    DonGia DECIMAL(10,0) not null,
    DonViTinh VARCHAR(250) not null,
    PRIMARY KEY (ID_NL)
);

CREATE TABLE PhieuNK (
    ID_NK INT auto_increment,
    ID_NV INT not null,
    NgayNK DATETIME,
    TrangThai VARCHAR(250) DEFAULT 'Chưa hoàn thành',
    TongTien DECIMAL(10,0),
    PRIMARY KEY (ID_NK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV),
    CHECK (TrangThai in ('Chưa hoàn thành', 'Hoàn thành'))
);

CREATE TABLE PhieuXK (
    ID_XK INT auto_increment,
    ID_NV INT not null,
    NgayXK DATETIME,
    TrangThai VARCHAR(250) DEFAULT 'Chưa hoàn thành',
    PRIMARY KEY (ID_XK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV),
    CHECK (TrangThai in ('Chưa hoàn thành', 'Hoàn thành'))
);

CREATE TABLE Kho (
    ID_NL INT,
    SLTon INT DEFAULT 0,
    PRIMARY KEY (ID_NL),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

CREATE TABLE CTNK (
    ID_NK INT ,
    ID_NL INT,
    SoLuong INT,
    ThanhTien INT,
    PRIMARY KEY (ID_NK, ID_NL),
    FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

CREATE TABLE CTXK (
    ID_XK INT ,
    ID_NL INT not null,
    SoLuong INT not null,
    PRIMARY KEY (ID_XK, ID_NL),
    FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

-- Function 

-- Function tính tổng số tiền từ CTHD ra HoaDon

DELIMITER $$
CREATE FUNCTION GetSumMoney(
	id_hd INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE totalMoney DECIMAL(10,0);
    
    SELECT SUM(Thanhtien) INTO totalMoney
    FROM CTHD
    WHERE CTHD.ID_HoaDon = id_hd
    GROUP BY CTHD.ID_HoaDon;
    
RETURN (totalMoney);
END$$
DELIMITER ;

-- Function lấy giá trị voucher từ Voucher ra Hoá Đơn

DELIMITER $$
CREATE FUNCTION GetValueVoucher(
	codeVoucher VARCHAR(210)
)
RETURNS DECIMAL(3,0)
DETERMINISTIC
BEGIN
	DECLARE voucherValue DECIMAL(3.0) DEFAULT 0;
    
    SELECT Voucher.Phantram INTO voucherValue 
    FROM Voucher
    WHERE Voucher.Code_Voucher = codeVoucher;
    
RETURN (voucherValue);
END$$
DELIMITER ;


-- Function Tính giá trị của mỗi món trong CTHD

DELIMITER $$
CREATE FUNCTION GetPriceFood(
    id_food INT
)
RETURNS DECIMAL(10,0)
DETERMINISTIC
BEGIN
    DECLARE priceFood DECIMAL(10,0);
    SELECT MonAn.DonGia INTO priceFood
    FROM MonAn WHERE MonAn.ID_MonAn = id_food;

RETURN (priceFood);
END$$
DELIMITER ;

-- Tính toán doanh số của khách hàng

DELIMITER $$
CREATE FUNCTION GetTotalSpending(
	id_kh INT
)
RETURNS DECIMAL(10,0)
DETERMINISTIC
BEGIN
	DECLARE totalSpending DECIMAL(10,0);
    SELECT SUM(HoaDon.TongTien) INTO totalSpending
    FROM HoaDon 
    WHERE HoaDon.ID_KH = id_KH
    GROUP BY (HoaDon.ID_KH);
    
RETURN (totalSpending);
END$$
DELIMITER ;



-- Lấy Đơn giá của Nguyên liệu

DELIMITER $$
CREATE FUNCTION GetPriceIngredient(
    id_ingredient INT
)
RETURNS DECIMAL(10,0)
DETERMINISTIC
BEGIN
    DECLARE priceIngredient DECIMAL(10,0);
    SELECT NguyenLieu.DonGia INTO priceIngredient
    FROM NguyenLieu WHERE NguyenLieu.ID_NL = id_ingredient;

RETURN (priceIngredient);
END$$
DELIMITER ;

-- Tính thành tiền của Phiếu NK

DELIMITER $$
CREATE FUNCTION GetSumReceiptNote(
	id_nk INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE totalMoney DECIMAL(10,0);
    
    SELECT SUM(Thanhtien) INTO totalMoney
    FROM CTNK
    WHERE CTNK.ID_NK = id_nk
    GROUP BY CTNK.ID_NK;
    
RETURN (totalMoney);
END$$
DELIMITER ;



-- Stored Procedure
-- Tạo người dùng từ tài khoản của quản lý
DELIMITER $$
CREATE PROCEDURE CreateAccount(
	IN p_email VARCHAR(250),
    IN p_matkhau VARCHAR(250),
    IN p_vaitro VARCHAR(250),
    IN p_verifycode VARCHAR(250),
    IN p_ten VARCHAR(250),
    IN p_sdt VARCHAR(250),
    IN p_ngayvl DATE,
    IN p_chucvu VARCHAR(250),
    IN p_id_nql VARCHAR(250)
)
BEGIN
	DECLARE p_id_nd INT DEFAULT 0;
    INSERT INTO NguoiDung (Email, Matkhau, VerifyCode, Vaitro)
    VALUES (p_email, p_matkhau, p_verifycode, p_vaitro);
	SELECT ID_ND INTO p_id_nd FROM NguoiDung WHERE NguoiDung.Email = p_email;
    IF p_id_nd <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi khi chèn dữ liệu vào bảng NguoiDung';
    ELSE
		IF (p_vaitro = 'Nhân viên bàn') THEN
			INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
			VALUES (p_ten, p_ngayvl, p_sdt, p_chucvu, p_id_nd, p_id_nql);
		ELSEIF (p_vaitro = 'Nhân viên kho') THEN
			INSERT INTO NhanVienKho (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
			VALUES (p_ten, p_ngayvl, p_sdt, p_chucvu, p_id_nd, p_id_nql);
		END IF;
	END IF;

END$$
DELIMITER ;

-- Tạo khách hàng mới

DELIMITER $$
CREATE PROCEDURE CreateCustomer (
	IN nameCustomer VARCHAR(250),
    IN phoneNumber VARCHAR(11)
)
BEGIN
    DECLARE timeNow DATE;
    SET timeNow = CURDATE();
    INSERT INTO KhachHang (TenKH, SDT, Ngaythamgia)
    VALUES (nameCustomer, phoneNumber, timeNow);
    
END$$
DELIMITER ;

-- Tạo Hoá Đơn Khi gọi món

CREATE PROCEDURE NewOrder (
	IN p_IDBan INT,
    IN p_IDNV INT
)
BEGIN
    INSERT INTO HoaDon (ID_NV, ID_Ban)
    VALUES (p_IDNV, p_IDBan);
    
    UPDATE Ban
    SET TrangThai = 'Đang sử dụng'
    WHERE Ban.ID_Ban = p_IDBan;
    
END$$
DELIMITER ;


-- Thanh toán từ Hoá Đơn

DELIMITER $$
CREATE PROCEDURE Payment (
	IN p_IDHD INT,
    IN p_IDKH INT,
    IN codeVoucher VARCHAR(210)
)
BEGIN
	DECLARE p_IDBan INT;
    
    SELECT ID_Ban INTO p_IDBan
    FROM HoaDon 
    WHERE HoaDon.ID_HoaDon = p_IDHD;
    
    UPDATE HoaDon 
    SET ID_KH = p_IDKH, NgayHD = NOW(), 
    Code_Voucher = codeVoucher, TrangThai = 'Đã thanh toán'
    WHERE HoaDon.ID_HoaDon = p_IDHD;
    
    UPDATE Ban
    SET TrangThai = 'Trống'
    WHERE Ban.ID_Ban = p_IDBan;
    
END$$
DELIMITER ;

-- Tạo Phiếu NK mới
DELIMITER $$
CREATE PROCEDURE NewInvoice (
    IN p_IDNV INT
)
BEGIN
    INSERT INTO PhieuNK(ID_NV)
    VALUES (p_IDNV);
END$$
DELIMITER ;

-- Hoàn thành phiếu NK
DELIMITER $$
CREATE PROCEDURE SaveInvoice (
    IN p_IDNK INT
)
BEGIN
    UPDATE PhieuNK
    SET NgayNK = NOW(), TrangThai = 'Hoàn thành'
    WHERE PhieuNK.ID_NK = p_IDNK;
    
END$$
DELIMITER ;

-- Tạo phiếu XK mới 

DELIMITER $$
CREATE PROCEDURE NewExportInvoice (
    IN p_IDNV INT
)
BEGIN
    INSERT INTO PhieuXK(ID_NV)
    VALUES (p_IDNV);
END$$
DELIMITER ;

-- Hoàn thành phiếu XK 
CREATE PROCEDURE SaveExportInvoice (
    IN p_IDXK INT
)
BEGIN
    UPDATE PhieuXK
    SET NgayXK = NOW(), TrangThai = 'Hoàn thành'
    WHERE PhieuXK.ID_XK = p_IDXK;
    
END$$
DELIMITER ;




-- Triggger

-- Tính tiền của mỗi món ăn vào CTHD

DELIMITER $$
CREATE TRIGGER before_insert_CTHD
	BEFORE INSERT ON CTHD
	FOR EACH ROW
BEGIN
	DECLARE priceFood DECIMAL(10,0);
    SET priceFood = GetPriceFood(NEW.ID_MonAn);
    
    SET NEW.ThanhTien = NEW.SoLuong * priceFood;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_update_CTHD
    BEFORE UPDATE ON CTHD
    FOR EACH ROW
BEGIN
    DECLARE priceFood DECIMAL(10,0);
    SET priceFood = GetPriceFood(NEW.ID_MonAn);
    
    SET NEW.ThanhTien = NEW.SoLuong * priceFood;
END$$
DELIMITER ;


-- Tính tiền món ăn Trong HoaDon mỗi khi CTHD Insert/Update/Delete

DELIMITER $$
CREATE TRIGGER after_insert_CTHD
	AFTER INSERT ON CTHD
	FOR EACH ROW
BEGIN
	UPDATE HoaDon 
	SET TienMonAn = GetSumMoney(NEW.ID_HoaDon)
	WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_update_CTHD
	AFTER UPDATE ON CTHD
	FOR EACH ROW
BEGIN
	UPDATE HoaDon 
	SET TienMonAn = GetSumMoney(NEW.ID_HoaDon)
	WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_delete_CTHD
	AFTER DELETE ON CTHD
	FOR EACH ROW
BEGIN
	UPDATE HoaDon 
	SET TienMonAn = GetSumMoney(OLD.ID_HoaDon)
	WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
END$$
DELIMITER ;



-- Tính Tổng Tiền và Tiền Giảm Trong HoaDon

DELIMITER $$
CREATE TRIGGER before_update_HoaDon
	BEFORE UPDATE ON HoaDon
	FOR EACH ROW
BEGIN
	DECLARE voucherValue DECIMAL(3.0);
    SET voucherValue = GetValueVoucher(New.Code_Voucher);
    SET NEW.TienGiam = NEW.TienMonAn*(voucherValue/100);
	SET NEW.TongTien = NEW.TienMonAn - NEW.TienGiam;
	
END$$
DELIMITER ;


-- Cập nhật Doanh số và điểm tích luỹ KhachHang

DELIMITER $$
CREATE TRIGGER after_update_HoaDon
	AFTER UPDATE ON HoaDon
	FOR EACH ROW
BEGIN
	DECLARE numberVoucher DECIMAL(3,0);
    
	UPDATE KhachHang
    SET DoanhSo = GetTotalSpending(NEW.ID_KH),
    Diemtichluy = (DoanhSo/1000)
    WHERE KhachHang.ID_KH = NEW.ID_KH;

    IF NEW.TrangThai = 'Đã thanh toán' THEN
		UPDATE Voucher
        SET SoLuong = SoLuong - 1
        WHERE Voucher.Code_Voucher = NEW.Code_Voucher;
    END IF;
    
END$$
DELIMITER ;

-- Cập nhật Thanh Tiền của mỗi NL trong CTNK

DELIMITER $$
CREATE TRIGGER before_insert_CTNK
	BEFORE INSERT ON CTNK
	FOR EACH ROW
BEGIN
	DECLARE priceIngredient DECIMAL(10,0);
    SET priceIngredient = GetPriceIngredient(NEW.ID_NL);
    SET NEW.ThanhTien = NEW.SoLuong * priceIngredient;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_update_CTNK
    BEFORE UPDATE ON CTNK
    FOR EACH ROW
BEGIN
    DECLARE priceIngredient DECIMAL(10,0);
    SET priceIngredient = GetPriceIngredient(NEW.ID_NL);
    SET NEW.ThanhTien = NEW.SoLuong * priceIngredient;
END$$
DELIMITER ;

-- Tính Tổng giá tiền trong Phiếu NK sau khi Update/Insert/Delete


DELIMITER $$
CREATE TRIGGER after_insert_CTNK
	AFTER INSERT ON CTNK
	FOR EACH ROW
BEGIN
	UPDATE PhieuNK 
	SET TongTien = GetSumReceiptNote(NEW.ID_NK)
	WHERE PhieuNK.ID_NK = NEW.ID_NK;

    UPDATE Kho
    SET SLTon = SLTon + NEW.SoLuong
    WHERE Kho.ID_NL = NEW.ID_NL;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_update_CTNK
	AFTER UPDATE ON CTNK
	FOR EACH ROW
BEGIN
	UPDATE PhieuNK 
	SET TongTien = GetSumReceiptNote(NEW.ID_NK)
	WHERE PhieuNK.ID_NK = NEW.ID_NK;

    UPDATE Kho
    SET SLTon = SLTon + NEW.SoLuong - OLD.SoLuong
    WHERE Kho.ID_NL = NEW.ID_NL;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_delete_CTNK
	AFTER DELETE ON CTNK
	FOR EACH ROW
BEGIN
	UPDATE PhieuNK 
	SET TongTien = GetSumReceiptNote(OLD.ID_NK)
	WHERE PhieuNK.ID_NK = OLD.ID_NK;

    UPDATE Kho
    SET SLTon = SLTon  - OLD.SoLuong
    WHERE Kho.ID_NL = OLD.ID_NL;

END$$
DELIMITER ;

-- Tính toán số lượng mất đi khi xuất kho CTXK


DELIMITER $$
CREATE TRIGGER after_insert_CTXK
	AFTER INSERT ON CTXK
	FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon - NEW.SoLuong
    WHERE Kho.ID_NL = NEW.ID_NL;

END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_update_CTXK
	AFTER UPDATE ON CTXK
	FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon - NEW.SoLuong + OLD.SoLuong
    WHERE Kho.ID_NL = NEW.ID_NL;

END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_delete_CTXK
	AFTER DELETE ON CTXK
	FOR EACH ROW
BEGIN
    UPDATE Kho
    SET SLTon = SLTon  + OLD.SoLuong
    WHERE Kho.ID_NL = OLD.ID_NL;

END$$
DELIMITER ;



-- Insert các nguyên liệu mới vào Kho

DELIMITER $$
CREATE TRIGGER after_insert_NguyenLieu
	AFTER INSERT ON NguyenLieu
	FOR EACH ROW
BEGIN
    INSERT Kho (ID_NL) VALUES(NEW.ID_NL);
END$$
DELIMITER ;


-- VIEW


-- View HoaDon
CREATE VIEW ViewHoaDon AS
SELECT HoaDon.ID_HoaDon, NhanVienBan.TenNV, KhachHang.TenKH, Ban.TenBan, HoaDon.Code_Voucher, HoaDon.TienMonAn, HoaDon.TienGiam, HoaDon.TongTien, HoaDon.TrangThai
FROM HoaDon
JOIN NhanVienBan ON HoaDon.ID_NV = NhanVienBan.ID_NV
JOIN KhachHang ON HoaDon.ID_KH = KhachHang.ID_KH
JOIN Ban ON HoaDon.ID_Ban = Ban.ID_Ban;


-- View CTHD

CREATE VIEW ViewCTHD AS
SELECT CTHD.ID_HoaDon, MonAn.TenMon, CTHD.SoLuong, MonAn.DonGia, CTHD.ThanhTien
FROM CTHD
JOIN MonAn ON CTHD.ID_MonAn = MonAn.ID_MonAn;

-- View NhanVienBan


CREATE VIEW ViewNhanVienBan AS
SELECT NhanVienBan.ID_NV, NhanVienBan.TenNV, NguoiDung.Email, NhanVienBan.NgayVL, NhanVienBan.ChucVu
FROM NhanVienBan
JOIN NguoiDung ON NhanVienBan.ID_ND = NguoiDung.ID_ND;


-- View NhanVienKho

CREATE VIEW ViewNhanVienKho AS
SELECT NhanVienKho.ID_NV, NhanVienKho.TenNV, NguoiDung.Email, NhanVienKho.NgayVL, NhanVienKho.ChucVu
FROM NhanVienKho
JOIN NguoiDung ON NhanVienKho.ID_ND = NguoiDung.ID_ND;

-- View PhieuNK


CREATE VIEW ViewPhieuNK AS
SELECT PhieuNK.ID_NK, PhieuNK.ID_NV, NhanVienKho.TenNV, PhieuNK.NgayNK, PhieuNK.TongTien, PhieuNK.TrangThai
FROM PhieuNK
JOIN NhanVienKho ON PhieuNK.ID_NV = NhanVienKho.ID_NV;

-- View PhieuXK


CREATE VIEW ViewPhieuXK AS
SELECT PhieuXK.ID_XK, PhieuXK.ID_NV, NhanVienKho.TenNV, PhieuXK.NgayXK, PhieuXK.TrangThai
FROM PhieuXK
JOIN NhanVienKho ON PhieuXK.ID_NV = NhanVienKho.ID_NV;


-- View CTNK

CREATE VIEW ViewCTNK AS
SELECT CTNK.ID_NK, CTNK.ID_NL, NguyenLieu.TenNL, CTNK.SoLuong, NguyenLieu.Donvitinh, NguyenLieu.DonGia, CTNK.ThanhTien
FROM CTNK
JOIN NguyenLieu ON CTNK.ID_NL = NguyenLieu.ID_NL;


-- View CTXK


CREATE VIEW ViewCTXK AS
SELECT CTXK.ID_XK, CTXK.ID_NL, NguyenLieu.TenNL, CTXK.SoLuong, NguyenLieu.Donvitinh
FROM CTXK
JOIN NguyenLieu ON CTXK.ID_NL = NguyenLieu.ID_NL;

-- View Kho


CREATE VIEW ViewKho AS
SELECT Kho.ID_NL, NguyenLieu.TenNL, Kho.SLTon, NguyenLieu.Donvitinh, NguyenLieu.DonGia
FROM Kho
JOIN NguyenLieu ON Kho.ID_NL = NguyenLieu.ID_NL;


-- Tạo chỉ mục cho bảng KhachHang trên cột TenKH
CREATE INDEX idx_tenkh ON KhachHang(TenKH);

-- Tạo chỉ mục cho bảng NhanVienBan trên cột TenNV
CREATE INDEX idx_tennv ON NhanVienBan(TenNV);

-- Tạo chỉ mục cho bảng MonAn trên cột TenMon
CREATE INDEX idx_tenmon ON MonAn(TenMon);

-- Tạo chỉ mục cho bảng HoaDon trên cột NgayHD
CREATE INDEX idx_ngayhd ON HoaDon(NgayHD);


-- Tạo chỉ mục cho bảng NguyenLieu trên cột TenNL
CREATE INDEX idx_tennl ON NguyenLieu(TenNL);

-- Tạo chỉ mục cho bảng PhieuNK trên cột NgayNK
CREATE INDEX idx_ngaynk ON PhieuNK(NgayNK);

-- Tạo chỉ mục cho bảng PhieuXK trên cột NgayNK
CREATE INDEX idx_ngayxk ON PhieuXK(NgayNK);

-- Tạo chỉ mục cho bảng Ban trên cột Vitri
CREATE INDEX idx_vitri ON Ban(Vitri);




-- Tạo ROLE
CREATE ROLE manager, ware_house_staff, table_staff, developer;

GRANT all ON mysql_res.* TO manager;
GRANT all ON mysql_res.* TO developer;


-- Cấp quyền cho vài trò nhân viên bàn
GRANT SELECT, UPDATE ON mysql_res.NguoiDung TO table_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.KhachHang TO table_staff;
GRANT SELECT, UPDATE ON mysql_res.NhanVienBan TO table_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.HoaDon TO table_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.CTHD TO table_staff;
GRANT SELECT ON mysql_res.MONAn TO table_staff;
GRANT SELECT, UPDATE ON mysql_res.Ban TO table_staff;
GRANT SELECT ON mysql_res.Voucher TO table_staff;

-- Cấp quyền cho vai trò nhân viên kho
GRANT SELECT, UPDATE ON mysql_res.NguoiDung TO ware_house_staff;
GRANT SELECT, UPDATE ON mysql_res.NhanVienKho TO ware_house_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.PhieuNK TO ware_house_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.PhieuXK TO ware_house_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.CTNK TO ware_house_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.CTXK TO ware_house_staff;
GRANT INSERT, SELECT, UPDATE ON mysql_res.NguyenLieu TO ware_house_staff;

-- Tạo các tài khoản truy cập cơ sở dữ liệu
CREATE USER manager@localhost IDENTIFIED BY 'manager123';
CREATE USER table_staff@localhost IDENTIFIED BY 'tablestaff123';
CREATE USER ware_house_staff@localhost IDENTIFIED BY 'warehousestaff123';
CREATE USER developer@localhost IDENTIFIED BY 'developer123';

-- Cấp quyền cho các tài khoản
GRANT manager TO manager@localhost;
GRANT table_staff TO table_staff@localhost;
GRANT ware_house_staff TO ware_house_staff@localhost;
GRANT developer TO developer@localhost;



INSERT INTO KhachHang (TenKH, SDT, Ngaythamgia)
VALUES
('Nguyễn Văn A','123456789', '2023-01-01'),
('Trần Thị B','123456788', '2023-01-15'),
('Lê Văn C','123456787', '2023-02-01'),
('Phạm Thị D','123456786', '2023-03-10'),
('Hoàng Văn E','123456785', '2023-04-05');




INSERT INTO NguoiDung (Email, Matkhau, VerifyCode, Trangthai, Vaitro)
VALUES
('phamdinhminh@gmail.com', 'password123', 'ADS123', 'Active', 'Nhân viên bàn'),
('dothiem@gmail.com', 'password123', 'DEF456', 'Active', 'Nhân viên bàn'),
('nguyenthithanh@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên bàn'),
('levangiang@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên bàn'),
('tranvanhung@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên bàn'),
('nguyenvantuyen@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên kho'),
('trancongvan@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên kho'),
('levankhiem@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên kho'),
('phamthila@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên kho'),
('hoangvanvu@gmail.com', 'password123', 'GHI789', 'Active', 'Nhân viên kho');


INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Phạm Đình Minh', '2023-01-02', '0912345678', 'Quản lý', 1, 1),
('Đỗ Thị Em', '2023-01-03', '0987654321', 'Phục vụ', 2, 1),
('Nguyễn Thị Thanh', '2023-01-04', '0934567890', 'Thu ngân', 3, 1),
('Lê Văn Giang', '2023-01-05', '0976543210', 'Phục vụ', 4, 1),
('Trần Văn Hưng', '2023-01-06', '0965432109', 'Phục vụ', 5, 1);



INSERT INTO NhanVienKho (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Nguyễn Văn Tuyền', '2023-01-07', '0954321098', 'Quản lý', 6, 1),
('Trần Công Văn', '2023-01-08', '0943210987', 'Nhân viên', 7, 1),
('Lê Văn Khiêm', '2023-01-09', '0932109876', 'Nhân viên', 8, 1),
('Phạm Thị Lã', '2023-01-10', '0921098765', 'Nhân viên', 9, 1),
('Hoàng Văn Vũ', '2023-01-11', '0910987654', 'Nhân viên', 10, 1);


INSERT INTO Voucher (Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem)
VALUES
('SUMMER2023', 'Giảm giá mùa hè', 10.00, 'Tất cả', 100, 10),
('WINTER2023', 'Giảm giá mùa đông', 15.00, 'Tất cả', 200, 15),
('SPRING2023', 'Giảm giá mùa xuân', 20.00, 'Tất cả', 150, 20),
('FALL2023', 'Giảm giá mùa thu', 25.00, 'Tất cả', 120, 25),
('NEWYEAR2023', 'Giảm giá năm mới', 30.00, 'Tất cả', 180, 30);



INSERT INTO Ban (TenBan, Vitri, Trangthai)
VALUES
('Ban A', 'Tầng 1', 'Trống'),
('Ban B', 'Tầng 1', 'Trống'),
('Ban C', 'Tầng 1', 'Trống'),
('Ban D', 'Tầng 1', 'Trống'),
('Ban F', 'Tầng 1', 'Trống'),
('Ban G', 'Tầng 2', 'Trống'),
('Ban H', 'Tầng 2', 'Đang sử dụng'),
('Ban I', 'Tầng 2', 'Đang sử dụng'),
('Ban K', 'Tầng 2', 'Đang sử dụng'),
('Ban L', 'Tầng 2', 'Trống');


INSERT INTO MonAn(TenMon, DonGia, Loai, TrangThai, DauBep, DanhGia, ImageUrl)
VALUES 
('Phở', 30000.00, 'Món chính', 'Còn hàng', 'Nguyễn Văn Hùng', 4.5, 'images/pho.png'),
('Cơm tấm', 40000.00, 'Món chính', 'Còn hàng', 'Trần Văn Nam', 3.5, 'images/comtam.png'),
('Bún bò', 35000.00, 'Món chính', 'Hết hàng', 'Lê Thị Oanh', 5, 'images/bunbo.png'),
('Chả giò', 25000.00, 'Món khai vị', 'Còn hàng', 'Phạm Thị Linh', 4, 'images/chagio.png'),
('Gỏi cuốn', 20000.00, 'Món khai vị', 'Còn hàng', 'Hoàng Văn Thanh', 3, 'images/goicuon.png');



INSERT INTO HoaDon (ID_NV, ID_Ban)
VALUES
(5, 5),
(1, 1),
(4, 2),
(4, 2),
(5, 3);


INSERT INTO CTHD (ID_HoaDon, ID_MonAn, SoLuong)
VALUES
(1, 1, 2),
(2, 1, 3),
(2, 2, 3),
(2, 3, 3),
(3, 2, 2),
(3, 3, 1),
(3, 1, 3),
(3, 5, 1),
(4, 2, 1),
(4, 3, 2),
(4, 4, 2),
(4, 1, 5),
(4, 5, 1),
(5, 5, 4);


INSERT INTO NguyenLieu (TenNL, DonGia, DonViTinh)
VALUES
('Gạo', 10000.00, 'kg'),
('Thịt', 20000.00, 'kg'),
('Rau', 5000.00, 'kg'),
('Trứng', 3000.00, 'quả'),
('Cá', 15000.00, 'kg');



INSERT INTO PhieuNK (ID_NV)
VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO CTNK (ID_NK, ID_NL, SoLuong)
VALUES
(1, 1, 10),
(2, 2, 20),
(3, 3, 30),
(4, 4, 40),
(5, 5, 50);


INSERT INTO PhieuXK (ID_NV)
VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO CTXK (ID_XK, ID_NL, SoLuong)
VALUES
(1, 1, 10),
(2, 2, 20),
(3, 3, 30),
(4, 4, 40),
(5, 5, 50);