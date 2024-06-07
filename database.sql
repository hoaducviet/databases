CREATE TABLE KhachHang (
    ID_KH INT auto_increment,
    TenKH VARCHAR(250),
    Ngaythamgia DATE,
    Doanhso DECIMAL(10,0),
    Diemtichluy DECIMAL(5,0),
    PRIMARY KEY (ID_KH)
);
 
CREATE TABLE NguoiDung (
    ID_ND INT auto_increment ,
    Email VARCHAR(250),
    Matkhau VARCHAR(250),
    VerifyCode VARCHAR(210),
    Trangthai VARCHAR(210),
    Vaitro VARCHAR(220),
    PRIMARY KEY (ID_ND)
);
 
CREATE TABLE NhanVienKho (
    ID_NV INT auto_increment,
    TenNV VARCHAR(250),
    NgayVL DATE,
    SDT VARCHAR(250),
    Chucvu VARCHAR(250),
    ID_ND INT,
    ID_NQL INT NULL,
    PRIMARY KEY (ID_NV),
    FOREIGN KEY (ID_NQL) REFERENCES NhanVienKho(ID_NV),
    FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND)
);
 
CREATE TABLE NhanVienBan (
    ID_NV INT auto_increment ,
    TenNV VARCHAR(250),
    NgayVL DATE,
    SDT VARCHAR(250),
    Chucvu VARCHAR(250),
    ID_ND INT,
    ID_NQL INT NULL,
    PRIMARY KEY (ID_NV),
    FOREIGN KEY (ID_NQL) REFERENCES NhanVienBan(ID_NV),
    FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND)
);
 
CREATE TABLE PhieuNK (
    ID_NK INT auto_increment,
    ID_NV INT,
    NgayNK DATE,
    Tongtien DECIMAL(10,0),
    PRIMARY KEY (ID_NK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV)
);
 
CREATE TABLE PhieuXK (
    ID_XK INT auto_increment ,
    ID_NV INT,
    NgayNK DATE,
    PRIMARY KEY (ID_XK),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienKho(ID_NV)
);
 
CREATE TABLE Ban (
    ID_Ban INT auto_increment ,
    TenBan VARCHAR(250),
    Vitri VARCHAR(250),
    Trangthai VARCHAR(250),
    PRIMARY KEY (ID_Ban)
);
 
 
CREATE TABLE MonAn (
    ID_MonAn INT auto_increment ,
    TenMon VARCHAR(250),
    DonGia DECIMAL(10,0),
    Loai VARCHAR(250),
    TrangThai VARCHAR(250),
    DauBep varchar (250),
    PRIMARY KEY (ID_MonAn)
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
 
CREATE TABLE NguyenLieu (
    ID_NL INT auto_increment ,
    TenNL VARCHAR(250),
    DonGia DECIMAL(10,0),
    DonViTinh VARCHAR(250),
    PRIMARY KEY (ID_NL)
);
 
CREATE TABLE Kho (
    ID_NL INT auto_increment ,
    SLTon INT,
    PRIMARY KEY (ID_NL),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);
 
CREATE TABLE HoaDon (
    ID_HoaDon INT auto_increment,
    ID_NV INT,
    ID_KH INT,
    ID_Ban INT,
    NgayHD DATE,
    Code_Voucher VARCHAR(210),
    TienGiam DECIMAL(10,0),
    Tongtien DECIMAL(10,0),
    Trangthai VARCHAR(250),
    PRIMARY KEY (ID_HoaDon),
    FOREIGN KEY (ID_NV) REFERENCES NhanVienBan(ID_NV),
    FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH),
    FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban),
    FOREIGN KEY (Code_Voucher) references Voucher(Code_Voucher)
);
 
CREATE TABLE CTHD (
    ID_HoaDon INT auto_increment ,
    ID_MonAn INT,
    SoLuong INT,
    ThanhTien DECIMAL(10,0),
    PRIMARY KEY (ID_HoaDon, ID_MonAn),
    FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon),
    FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn)
);
 
 
CREATE TABLE CTNK (
    ID_NK INT auto_increment ,
    ID_NL INT,
    SoLuong INT,
    Thanhtoan INT,
    PRIMARY KEY (ID_NK, ID_NL),
    FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);
 
CREATE TABLE CTXK (
    ID_XK INT auto_increment ,
    ID_NL INT,
    SoLuong INT,
    PRIMARY KEY (ID_XK, ID_NL),
    FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK),
    FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL)
);