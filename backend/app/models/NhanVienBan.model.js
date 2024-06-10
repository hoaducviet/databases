const db = require('../common/connect');
const NhanVienBan = function (nhanvienban) {
    this.id_nv = nhanvienban.id_nv;
    this.tenNV = nhanvienban.tenNV;
    this.ngayVL = nhanvienban.ngayVL;
    this.sdt = nhanvienbạn.sdt;
    this.chucvu = nhanvienban.chucvu;
    this.id_nd = nhanvienban.id_nd;
    this.id_nql = nhanvienban.id_nql;
}


NhanVienBan.get_all = function(result){
    db.query("SELECT * FROM NhanVienBan", function(err, nhanvienban){
        if(err){
            result(err);
        } else {
            result(nhanvienban);
        }
    })
}

NhanVienBan.getById = function(id_kh, result) {
    // console.log(id)
    db.query(`SELECT * FROM NhanVienKho where id_kh = ${id_kh}`, function(err, nhanvienkho){
        if(err || nhanvienkho.length == 0){
            result(null);
        } else {
            result(nhanvienkho[0]);
        }
    })
}

NhanVienBan.create = function(data, result) {
    db.query("insert into NhanVienKho set ?", data, function(err, nhanvienkho){
        if(err){
            result(null);
        } else {
            result({id_kh: nhanvienkho.insertId, ...data});
        }
    })
}

NhanVienBan.remove = function(id_kh, result) {

    db.query("delete from NhanVienKho where id = ?", id_kh, function(err, khachhang){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id_kh)
        }
    })

}


NhanVienBan.update = function(data, result) {

    db.query("update NhanVienKho set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = NhanVienBan;