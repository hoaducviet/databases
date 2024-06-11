const db = require('../common/connect');
const CTHD = function (cthd) {
    this.id_hoadon = cthd.id_hoadon;
    this.id_monan = cthd.id_monan;
    this.id_soluong = hoadon.soluong;
    this.id_thanhtien = hoadon.thanhtien;
}


CTHD.get_all = function(result){
    db.query("SELECT * FROM CTHD", function(err, cthd){
        if(err){
            result(err);
        } else {
            result(cthd)
        }
    })
}


CTHD.getById = function(id, result) {
    const query = `SELECT HoaDon.ID_HoaDon, MonAn.TenMon, CTHD.SoLuong, CTHD.ThanhTien FROM CTHD JOIN HoaDon ON CTHD.ID_HoaDon = HoaDon.ID_HoaDon JOIN MonAn ON CTHD.ID_MonAn = MonAn.ID_MonAn WHERE HoaDon.ID_HoaDon=${id}`
    db.query(query, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


CTHD.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


CTHD.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


CTHD.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


CTHD.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}

module.exports = CTHD;