-- Tạo chỉ mục cho bảng KhachHang trên cột TenKH
CREATE INDEX idx_tenkh ON KhachHang(TenKH);

-- Tạo chỉ mục cho bảng NhanVienBan trên cột TenNV
CREATE INDEX idx_tennv ON NhanVienBan(TenNV);

-- Tạo chỉ mục cho bảng MonAn trên cột TenMon
CREATE INDEX idx_tenmon ON MonAn(TenMon);

-- Tạo chỉ mục cho bảng HoaDon trên cột NgayHD
CREATE INDEX idx_ngayhd ON HoaDon(NgayHD);

-- Tạo chỉ mục cho bảng CTHD trên cột ID_HoaDon
CREATE INDEX idx_id_hoadon ON CTHD(ID_HoaDon);

-- Tạo chỉ mục cho bảng CTHD trên cột ID_MonAn
CREATE INDEX idx_id_monan ON CTHD(ID_MonAn);

-- Tạo chỉ mục cho bảng NguyenLieu trên cột TenNL
CREATE INDEX idx_tennl ON NguyenLieu(TenNL);

-- Tạo chỉ mục cho bảng PhieuNK trên cột NgayNK
CREATE INDEX idx_ngaynk ON PhieuNK(NgayNK);

-- Tạo chỉ mục cho bảng PhieuXK trên cột NgayNK
CREATE INDEX idx_ngayxk ON PhieuXK(NgayNK);

-- Tạo chỉ mục cho bảng Ban trên cột Vitri
CREATE INDEX idx_vitri ON Ban(Vitri);
