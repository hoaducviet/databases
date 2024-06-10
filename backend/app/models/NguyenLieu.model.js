const db = require('../common/connect');
const NguyenLieu = function (nguyenlieu) {
    this.id_nl = nguyenlieu.id_nl;
    this.tenNL = nguyenlieu.tenNL;
    this.dongia = nguyenlieu.dongia;
    this.donvitinh = nguyenlieu.donvitinh;

}


NguyenLieu.get_all = function(result){
    db.query("SELECT * FROM NguyenLieu", function(err, nguyenLieu){
        if(err){
            result(err);
        } else {
            result(nguyenLieu)
        }
    })
}


NguyenLieu.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM CTHD where id_hoadon = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


NguyenLieu.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


NguyenLieu.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


NguyenLieu.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


NguyenLieu.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}

module.exports = NguyenLieu;