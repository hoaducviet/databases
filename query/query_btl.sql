--1. /* Cập nhật 6 thông báo gần nhất */
CREATE TABLE RecentTransactionsSimple (
    TransactionTime TIME,
    TransactionDescription VARCHAR(255),
    PRIMARY KEY (TransactionTime, TransactionDescription)
);
-- Thêm giao dịch từ phiếu nhập kho
INSERT INTO RecentTransactionsSimple (TransactionTime, TransactionDescription)
SELECT TIME(NgayNK), CONCAT('New sale recorded #', ID_NK)
FROM PhieuNK;

-- Thêm giao dịch từ phiếu xuất kho
INSERT INTO RecentTransactionsSimple (TransactionTime, TransactionDescription)
SELECT TIME(NgayNK), CONCAT('Payment made of $', (SELECT SUM(Thanhtoan) FROM CTNK WHERE CTNK.ID_NK = PhieuNK.ID_NK), ' to supplier')
FROM PhieuXK;

-- Thêm giao dịch từ hóa đơn bán hàng
INSERT INTO RecentTransactionsSimple (TransactionTime, TransactionDescription)
SELECT TIME(NgayHD), CONCAT('Payment received from Customer ', ID_KH, ' of $', Tongtien)
FROM HoaDon
WHERE Trangthai = 'Completed';
SELECT * FROM RecentTransactionsSimple
ORDER BY TransactionTime DESC
LIMIT 6;

-- 2. Bảng thông tin món ăn bán chạy nhất 
-- Tạo bảng mới phù hợp với yêu cầu của front end
CREATE TABLE DanhGiaBanHang (
    ID INT AUTO_INCREMENT,
    TenMon VARCHAR(250),
    DanhGia VARCHAR(50),
    DoanhThu DECIMAL(10, 2),
    PRIMARY KEY (ID)
);

-- Thêm dữ liệu vào bảng mới từ các bảng MonAn và CTHD
INSERT INTO DanhGiaBanHang (TenMon, DanhGia, DoanhThu)
SELECT MA.TenMon,
       CASE 
           WHEN SUM(CTHD.SoLuong) > 50 THEN 'High'
           WHEN SUM(CTHD.SoLuong) BETWEEN 10 AND 50 THEN 'Medium'
           ELSE 'Low'
       END AS DanhGia,
       SUM(CTHD.SoLuong * MA.DonGia) AS DoanhThu
FROM MonAn MA
JOIN CTHD ON MA.ID_MonAn = CTHD.ID_MonAn
GROUP BY MA.ID_MonAn, MA.TenMon;

-- Truy vấn để lấy thông tin về món ăn bán chạy để hiển thị trên front end
SELECT ID, TenMon, DanhGia, DoanhThu FROM DanhGiaBanHang
ORDER BY DoanhThu DESC;



