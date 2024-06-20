const db = require('../common/connect');
const Ban = function (ban) {
    this.id_ban = ban.id_ban;
    this.tenBan = ban.tenBan;
    this.vitri = ban.vitri;
    this.trangthai = ban.trangthai;
}

Ban.get_all = function(result){
    db.query("SELECT * FROM Ban", function(err, ban){
        if(err){
            result(err);
        } else {
            result(ban)
        }
    })
} 


Ban.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM users where id = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


Ban.create = function(data, result) {
    db.query("insert into users set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


Ban.remove = function(id, result) {

    db.query("delete from users where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


Ban.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


Ban.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}
module.exports = Ban;