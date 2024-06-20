const db = require('../common/connect');
const NhanVienKho = function (nhanvienkho) {
    this.id_nv = nhanvienkho.id_nv;
    this.tenNV = nhanvienkho.tenNV;
    this.ngayVL = nhanvienkho.ngayVL;
    this.sdt = nhanvienkho.sdt;
    this.chucvu = nhanvienkho.chucvu;
    this.id_nd = nhanvienkho.id_nd;
    this.id_nql = nhanvienkho.id_nql;
}


NhanVienKho.get_all = function(result){
    db.query("SELECT * FROM ViewNhanVienKho", function(err, nhanvienkho){
        if(err){
            result(err);
        } else {
            result(nhanvienkho);
        }
    })
}

NhanVienKho.getById = function(id_kh, result) {
    // console.log(id)
    db.query(`SELECT * FROM NhanVienKho where id_kh = ${id_kh}`, function(err, nhanvienkho){
        if(err || nhanvienkho.length == 0){
            result(null);
        } else {
            result(nhanvienkho[0]);
        }
    })
}

NhanVienKho.create = function(data, result) {
    db.query("insert into NhanVienKho set ?", data, function(err, nhanvienkho){
        if(err){
            result(null);
        } else {
            result({id_kh: nhanvienkho.insertId, ...data});
        }
    })
}

NhanVienKho.remove = function(id_kh, result) {

    db.query("delete from NhanVienKho where id = ?", id_kh, function(err, khachhang){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id_kh)
        }
    })

}


NhanVienKho.update = function(data, result) {

    db.query("update NhanVienKho set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = NhanVienKho;