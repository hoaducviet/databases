const db = require('../common/connect');
const NguoiDung = function (nguoidung) {
    this.id_nd = nguoidung.id_nd;
    this.email = nguoidung.email;
    this.matkhau = nguoidung.matkhau;
    this.verifycode = nguoidung.verifycode;
    this.trangthai = nguoidung.trangthai;
    this.vaitro = nguoidung.vaitro;
}


NguoiDung.get_all = function(result){
    db.query("SELECT * FROM NguoiDung", function(err, nguoidung){
        if(err){
            result(err);
        } else {
            result(nguoidung);
        }
    })
}

NguoiDung.getById = function(id_nd, result) {
    // console.log(id)
    db.query(`SELECT * FROM NguoiDung where id_nd = ${id_nd}`, function(err, nguoidung){
        if(err || nguoidung.length == 0){
            result(null);
        } else {
            result(nguoidung[0]);
        }
    })
}

NguoiDung.create = function(data, result) {
    db.query("insert into NguoiDung set ?", data, function(err, nguoidung){
        if(err){
            result(null);
        } else {
            result({id: nguoidung.insertId, ...data});
        }
    })
}

NguoiDung.remove = function(id_nd, result) {

    db.query("delete from NguoiDung where id = ?", id_nd, function(err, nguoidung){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


NguoiDung.update = function(data, result) {

    db.query("update NguoiDung set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = NguoiDung;