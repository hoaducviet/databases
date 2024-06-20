const db = require('../common/connect');
const CTHD = function (cthd) {
    this.id_hoadon = cthd.id_hoadon;
    this.id_monan = cthd.id_monan;
    this.id_soluong = hoadon.soluong;
    this.id_thanhtien = hoadon.thanhtien;
}



CTHD.getById = function(id, result) {
    const query = `SELECT * FROM ViewCTHD WHERE ID_HoaDon = ${id}`
    db.query(query, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            console.log(user) 
            result(user);
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