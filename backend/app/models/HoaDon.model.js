const db = require('../common/connect');
const HoaDon = function (hoadon) {
    this.id_hoadon = hoadon.id_hoadon;
    this.id_nv = hoadon.id_nv;
    this.id_kh = hoadon.id_kh;
    this.id_ban = hoadon.id_ban;
    this.ngayHD = hoadon.ngayHD;
    this.code_voucher = hoadon.code_voucher;
    // this.tienmonan = hoadon.tienmonan;
    this.tiengiam = hoadon.tiengiam;
    this.tongtien = hoadon.tongtien;
    this.trangthai = hoadon.trangthai;
}


HoaDon.get_all = function(result){
    db.query("SELECT * FROM HoaDon", function(err, hoadon){
        if(err){
            result(err);
        } else {
            result(hoadon)
        }
    })
}


HoaDon.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM HoaDon where id_hoadon = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


HoaDon.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


HoaDon.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


HoaDon.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


HoaDon.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}
module.exports = HoaDon;