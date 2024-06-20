const db = require('../common/connect');
const CTNK = function (ctnk) {
    this.id_nk = ctnk.id_nk;
    this.id_nl = ctnk.id_nl;
    this.soluong = ctnk.soluong;
    this.thanhtien = ctnk.thanhtien;
}



CTNK.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM VIEWCTNK WHERE ID_NK = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user);
        }
    })
}


CTNK.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


CTNK.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


CTNK.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


CTNK.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}

module.exports = CTNK;