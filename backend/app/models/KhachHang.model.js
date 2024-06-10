const db = require('../common/connect');
const KhachHang = function (khachhang) {
    this.id_kh = khachhang.id_kh;
    this.tenKH = khachhang.tenKH;
    this.ngaythamgia = khachhang.ngaythamgia;
    this.doanhso = khachhang.doanhso;
    this.diemtichluy = khachhang.diemtichluy;
}


KhachHang.get_all = function(result){
    db.query("SELECT * FROM KhachHang", function(err, khachhang){
        if(err){
            result(err);
        } else {
            result(khachhang);
        }
    })
}

KhachHang.getById = function(id_kh, result) {
    // console.log(id)
    db.query(`SELECT * FROM KhachHang where id_kh = ${id_kh}`, function(err, khachhang){
        if(err || khachhang.length == 0){
            result(null);
        } else {
            result(khachhang[0]);
        }
    })
}

KhachHang.create = function(data, result) {
    db.query("insert into KhachHang set ?", data, function(err, khachhang){
        if(err){
            result(null);
        } else {
            result({id_kh: khachhang.insertId, ...data});
        }
    })
}

KhachHang.remove = function(id_kh, result) {

    db.query("delete from KhachHang where id = ?", id_kh, function(err, khachhang){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id_kh)
        }
    })

}


KhachHang.update = function(data, result) {

    db.query("update KhachHang set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = KhachHang;