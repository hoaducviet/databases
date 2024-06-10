DROP DATABASE IF EXISTS mysql_res;
CREATE DATABASE mysql_res;
use mysql_res;

CREATE TABLE KhachHang (
    ID_KH INT auto_increment,
    TenKH VARCHAR(250) not null,
    Ngaythamgia DATE,
    Doanhso DECIMAL(10,0),
    Diemtichluy DECIMAL(5,0),
    PRIMARY KEY (ID_KH)
);


CREATE TABLE NguoiDung (
    ID_ND INT auto_increment,
    Email VARCHAR(250) not null,
    Matkhau VARCHAR(250) not null,
    VerifyCode VARCHAR(210),
    Trangthai VARCHAR(210) not null,
    Vaitro VARCHAR(220) not null,
    PRIMARY KEY (ID_ND),
    UNIQUE (Email),
    CHECK (Vaitro in ('manager', 'staff', 'customer')),
    CHECK (Trangthai in ('inactive', 'active'))
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
    CHECK (Chucvu in ('staff', 'manager'))
);

CREATE TABLE NhanVienBan (
    ID_NV INT auto_increment,
    TenNV VARCHAR(250) not null,
    NgayVL DATE,
    SDT VARCHAR(250) not null,
    Chucvu VARCHAR(250) not null,
    ID_ND INT not null,
    ID_NQL INT NULL,
    PRIMARY KEY (ID_NV),
    FOREIGN KEY (ID_NQL) REFERENCES NhanVienBan(ID_NV),
    FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND),
    CHECK (Chucvu in ('waiter', 'cashier', 'manager'))
);

CREATE TABLE PhieuNK (
    ID_NK INT auto_increment,
    ID_NV INT not null,
    NgayNK DATE not null,
    Tongtien DECIMAL(10,0),
    PRIMARY KEY (ID_NK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV)
);

CREATE TABLE PhieuXK (
    ID_XK INT auto_increment,
    ID_NV INT not null,
    NgayXK DATE not null,
    PRIMARY KEY (ID_XK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV)
);

CREATE TABLE Ban (
    ID_Ban INT auto_increment,
    TenBan VARCHAR(250),
    Vitri VARCHAR(250),
    Trangthai VARCHAR(250) not null,
    PRIMARY KEY (ID_Ban),
    CHECK (Trangthai in ('Trống', 'Đã đặt', 'Đang sử dụng'))
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
    ID_KH INT null,
    ID_Ban INT not null,
    NgayHD DATE not null,
    Code_Voucher VARCHAR(210),
    TienGiam DECIMAL(10,0),
    Tongtien DECIMAL(10,0),
    Trangthai VARCHAR(250),
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
    DauBep varchar (250),
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

CREATE TABLE Kho (
    ID_NL INT,
    SLTon INT,
    PRIMARY KEY (ID_NL),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);

CREATE TABLE CTNK (
    ID_NK INT ,
    ID_NL INT,
    SoLuong INT,
    Thanhtien INT,
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


INSERT INTO KhachHang (TenKH, Ngaythamgia, Doanhso, Diemtichluy)
VALUES
('Nguyễn Văn A', '2023-01-01', 1500000.00, 120.00),
('Trần Thị B', '2023-01-15', 2000000.00, 150.00),
('Lê Văn C', '2023-02-01', 2500000.00, 180.00),
('Phạm Thị D', '2023-03-10', 3000000.00, 200.00),
('Hoàng Văn E', '2023-04-05', 3500000.00, 250.00);

INSERT INTO NguoiDung (Email, Matkhau, VerifyCode, Trangthai, Vaitro)
VALUES
('nguyenhoa@gmail.com', 'password123', 'ADS123', 'active', 'customer'),
('tranbanh@gmail.com', 'password123', 'DEF456', 'active', 'manager'),
('lethuha@gmail.com', 'password123', 'GHI789', 'active', 'customer'),
('phambangban@gmail.com', 'password123', 'JKL012', 'active', 'staff'),
('hoangvanem@gmail.com', 'password123', 'MNO345', 'active', 'staff'),
('nguyenanhhoa@gmail.com', 'password123', 'ABC123', 'active', 'customer'),
('tranb@gmail.com', 'password123', 'DEF456', 'inactive', 'manager'),
('lec@gmail.com', 'password123', 'GHI789', 'active', 'customer'),
('phamd@gmail.com', 'password123', 'JKL012', 'active', 'staff'),
('hoange@gmail.com', 'password123', 'MNO345', 'inactive', 'staff');

INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Phạm Đình D', '2023-01-02', '0912345678', 'manager', 1, 1),
('Đỗ Thị E', '2023-01-03', '0987654321', 'waiter', 2, 1),
('Nguyễn Thị F', '2023-01-04', '0934567890', 'cashier', 3, 1),
('Lê Văn G', '2023-01-05', '0976543210', 'waiter', 4, 1),
('Trần Văn H', '2023-01-06', '0965432109', 'waiter', 5, 1);

INSERT INTO NhanVienKho (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Nguyễn Văn I', '2023-01-07', '0954321098', 'manager', 1, 1),
('Trần Thị J', '2023-01-08', '0943210987', 'staff', 2, 1),
('Lê Văn K', '2023-01-09', '0932109876', 'staff', 3, 1),
('Phạm Thị L', '2023-01-10', '0921098765', 'staff', 4, 1),
('Hoàng Văn M', '2023-01-11', '0910987654', 'staff', 5, 1);

INSERT INTO PhieuNK (ID_NV, NgayNK, Tongtien)
VALUES
(1, '2023-01-12', 500000.00),
(2, '2023-01-13', 600000.00),
(3, '2023-01-14', 700000.00),
(4, '2023-01-15', 800000.00),
(5, '2023-01-16', 900000.00);

INSERT INTO NguyenLieu (TenNL, DonGia, DonViTinh)
VALUES
('Gạo', 10000.00, 'kg'),
('Thịt', 20000.00, 'kg'),
('Rau', 5000.00, 'kg'),
('Trứng', 3000.00, 'quả'),
('Cá', 15000.00, 'kg');

INSERT INTO Kho (ID_NL, SLTon)
VALUES
(1, 100),
(2, 200),
(3, 300),
(4, 400),
(5, 500);

INSERT INTO PhieuXK (ID_NV, NgayXK)
VALUES
(1, '2023-02-01'),
(2, '2023-02-02'),
(3, '2023-02-03'),
(4, '2023-02-04'),
(5, '2023-02-05');

INSERT INTO CTXK (ID_XK, ID_NL, SoLuong)
VALUES
(1, 1, 10),
(2, 2, 20),
(3, 3, 30),
(4, 4, 40),
(5, 5, 50);

INSERT INTO Ban (TenBan, Vitri, Trangthai)
VALUES
('Ban A', 'Tầng 1', 'Trống'),
('Ban B', 'Tầng 1', 'Đang sử dụng'),
('Ban C', 'Tầng 1', 'Trống'),
('Ban D', 'Tầng 1', 'Đã đặt'),
('Ban E', 'Tầng 1', 'Trống'),
('Ban A', 'Tầng 2', 'Đang sử dụng'),
('Ban B', 'Tầng 2', 'Trống'),
('Ban C', 'Tầng 2', 'Đã đặt'),
('Ban D', 'Tầng 2', 'Đang sử dụng'),
('Ban E', 'Tầng 2', 'Trống');

INSERT INTO Voucher (Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem)
VALUES
('SUMMER2023', 'Giảm giá mùa hè', 10.00, 'Tất cả', 100, 10),
('WINTER2023', 'Giảm giá mùa đông', 15.00, 'Tất cả', 200, 15),
('SPRING2023', 'Giảm giá mùa xuân', 20.00, 'Tất cả', 150, 20),
('FALL2023', 'Giảm giá mùa thu', 25.00, 'Tất cả', 120, 25),
('NEWYEAR2023', 'Giảm giá năm mới', 30.00, 'Tất cả', 180, 30);

INSERT INTO HoaDon (ID_NV, ID_KH, ID_Ban, NgayHD, Code_Voucher, TienGiam, Tongtien, Trangthai)
VALUES
(1, 1, 1, '2023-06-01', 'SUMMER2023', 100000.00, 900000.00, 'Đã thanh toán'),
(2, 2, 2, '2023-06-01', NULL, 0.00, 500000.00, 'Chưa thanh toán'),
(3, 3, 3, '2023-06-02', 'WINTER2023', 150000.00, 850000.00, 'Đã thanh toán'),
(4, 4, 4, '2023-06-02', 'SPRING2023', 200000.00, 800000.00, 'Chưa thanh toán'),
(5, 5, 5, '2023-06-03', 'FALL2023', 250000.00, 750000.00, 'Đã thanh toán');

INSERT INTO CTNK (ID_NK, ID_NL, SoLuong, Thanhtien)
VALUES
(1, 1, 10, 100000.00),
(2, 2, 20, 200000.00),
(3, 3, 30, 300000.00),
(4, 4, 40, 400000.00),
(5, 5, 50, 500000.00);

INSERT INTO MonAn (TenMon, DonGia, Loai, Trangthai, DauBep, ImageUrl)
VALUES
('Phở', 30000.00, 'Món chính', 'Còn hàng', 'Nguyễn Văn Chef1', 'images/pho.png'),
('Cơm tấm', 40000.00, 'Món chính', 'Còn hàng', 'Trần Văn Chef2', 'images/comtam.png'),
('Bún bò', 35000.00, 'Món chính', 'Hết hàng', 'Lê Thị Chef3', 'images/bunbo.png'),
('Chả giò', 25000.00, 'Món khai vị', 'Còn hàng', 'Phạm Thị Chef4', 'images/chagio.png'),
('Gỏi cuốn', 20000.00, 'Món khai vị', 'Còn hàng', 'Hoàng Văn Chef5', 'images/goicuon.png');

INSERT INTO CTHD (ID_HoaDon, ID_MonAn, SoLuong, ThanhTien)
VALUES
(1, 1, 2, 60000.00),
(2, 2, 3, 120000.00),
(3, 3, 1, 35000.00),
(4, 4, 5, 100000.00),
(5, 5, 4, 100000.00);

