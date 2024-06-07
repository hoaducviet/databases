-- Bảng KhachHang
INSERT INTO KhachHang (TenKH, Ngaygiamgia, Doanhso, Diemtichluy)
VALUES
('Nguyễn Văn A', '2023-01-01', 1500000.00, 120.00),
('Trần Thị B', '2023-01-15', 2000000.00, 150.00),
('Lê Văn C', '2023-02-01', 2500000.00, 180.00),
('Phạm Thị D', '2023-03-10', 3000000.00, 200.00),
('Hoàng Văn E', '2023-04-05', 3500000.00, 250.00);
-- Bảng NguoiDung
INSERT INTO NguoiDung (Email, Matkhau, VerifyCode, Trangthai, Vaitro)
VALUES
('nguyena@gmail.com', 'password123', 'ABC123', 'active', 'user'),
('tranb@gmail.com', 'password123', 'DEF456', 'inactive', 'admin'),
('lec@gmail.com', 'password123', 'GHI789', 'active', 'user'),
('phamd@gmail.com', 'password123', 'JKL012', 'active', 'user'),
('hoange@gmail.com', 'password123', 'MNO345', 'inactive', 'user');
-- Bảng NhanVienBan
INSERT INTO NhanVienBan (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Phạm Đình D', '2023-01-02', '0912345678', 'Bán hàng', 1, 1),
('Đỗ Thị E', '2023-01-03', '0987654321', 'Quản lý', 2, NULL),
('Nguyễn Thị F', '2023-01-04', '0934567890', 'Bán hàng', 3, 2),
('Lê Văn G', '2023-01-05', '0976543210', 'Bán hàng', 4, 2),
('Trần Văn H', '2023-01-06', '0965432109', 'Bán hàng', 5, 2);
-- Bảng NhanVienKho
INSERT INTO NhanVienKho (TenNV, NgayVL, SDT, Chucvu, ID_ND, ID_NQL)
VALUES
('Nguyễn Văn I', '2023-01-07', '0954321098', 'Quản lý kho', 1, 1),
('Trần Thị J', '2023-01-08', '0943210987', 'Kho', 2, 1),
('Lê Văn K', '2023-01-09', '0932109876', 'Kho', 3, 1),
('Phạm Thị L', '2023-01-10', '0921098765', 'Kho', 4, 2),
('Hoàng Văn M', '2023-01-11', '0910987654', 'Kho', 5, 2);
-- Bảng PhieuNK
INSERT INTO PhieuNK (ID_NV, NgayNK, Tongtien)
VALUES
(1, '2023-01-12', 500000.00),
(2, '2023-01-13', 600000.00),
(3, '2023-01-14', 700000.00),
(4, '2023-01-15', 800000.00),
(5, '2023-01-16', 900000.00);

 
-- Bảng NguyenLieu
INSERT INTO NguyenLieu (TenNL, DonGia, DonViTinh)
VALUES
('Gạo', 10000.00, 'kg'),
('Thịt', 20000.00, 'kg'),
('Rau', 5000.00, 'kg'),
('Trứng', 3000.00, 'quả'),
('Cá', 15000.00, 'kg');
-- Bảng Kho
INSERT INTO Kho (ID_NL, SLTon)
VALUES
(1, 100),
(2, 200),
(3, 300),
(4, 400),
(5, 500);
-- Bảng PhieuXK
INSERT INTO PhieuXK (ID_NV, NgayNK)
VALUES
(1, '2023-02-01'),
(2, '2023-02-02'),
(3, '2023-02-03'),
(4, '2023-02-04'),
(5, '2023-02-05');
-- Bảng CTXK
INSERT INTO CTXK (ID_XK, ID_NL, SoLuong)
VALUES
(1, 1, 10),
(2, 2, 20),
(3, 3, 30),
(4, 4, 40),
(5, 5, 50);
-- Bảng Ban
INSERT INTO Ban (TenBan, Vitri, Trangthai)
VALUES
('Ban A', 'Tầng 1', 'Trống'),
('Ban B', 'Tầng 2', 'Đầy'),
('Ban C', 'Tầng 3', 'Trống'),
('Ban D', 'Tầng 4', 'Đầy'),
('Ban E', 'Tầng 5', 'Trống');

 
-- Bảng Voucher
INSERT INTO Voucher (Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem)
VALUES
('SUMMER2023', 'Giảm giá mùa hè', 10.00, 'Tất cả', 100, 10),
('WINTER2023', 'Giảm giá mùa đông', 15.00, 'Tất cả', 200, 15),
('SPRING2023', 'Giảm giá mùa xuân', 20.00, 'Tất cả', 150, 20),
('FALL2023', 'Giảm giá mùa thu', 25.00, 'Tất cả', 120, 25),
('NEWYEAR2023', 'Giảm giá năm mới', 30.00, 'Tất cả', 180, 30);
-- Bảng HoaDon
INSERT INTO HoaDon (ID_NV, ID_KH, ID_Ban, NgayHD, Code_Voucher, TienGiam, Tongtien, Trangthai)
VALUES
(1, 1, 1, '2023-06-01', 'SUMMER2023', 100000.00, 900000.00, 'Đã thanh toán'),
(2, 2, 2, '2023-06-01', NULL, 0.00, 500000.00, 'Chưa thanh toán'),
(3, 3, 3, '2023-06-02', 'WINTER2023', 150000.00, 850000.00, 'Đã thanh toán'),
(4, 4, 4, '2023-06-02', 'SPRING2023', 200000.00, 800000.00, 'Chưa thanh toán'),
(5, 5, 5, '2023-06-03', 'FALL2023', 250000.00, 750000.00, 'Đã thanh toán');
 
-- Bảng CTNK
INSERT INTO CTNK (ID_NK, ID_NL, SoLuong, Thanhtoan)
VALUES
(1, 1, 10, 100000.00),
(2, 2, 20, 200000.00),
(3, 3, 30, 300000.00),
(4, 4, 40, 400000.00),
(5, 5, 50, 500000.00);
-- Bảng MonAn
INSERT INTO MonAn (TenMon, DonGia, Loai, Trangthai, DauBep)
VALUES
('Phở', 30000.00, 'Món chính', 'Còn hàng', 'Nguyễn Văn Chef1'),
('Cơm tấm', 40000.00, 'Món chính', 'Còn hàng', 'Trần Văn Chef2'),
('Bún bò', 35000.00, 'Món chính', 'Hết hàng', 'Lê Thị Chef3'),
('Chả giò', 25000.00, 'Món khai vị', 'Còn hàng', 'Phạm Thị Chef4'),
('Gỏi cuốn', 20000.00, 'Món khai vị', 'Còn hàng', 'Hoàng Văn Chef5');

-- Bảng CTHD
INSERT INTO CTHD (ID_HoaDon, ID_MonAn, SoLuong, ThanhTien)
VALUES
(1, 1, 2, 60000.00),
(2, 2, 3, 120000.00),
(3, 3, 1, 35000.00),
(4, 4, 5, 100000.00),
(5, 5, 4, 100000.00);