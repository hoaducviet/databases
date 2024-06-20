const db = require('../common/connect');
const Voucher = function (voucher) {
    this.code_voucher = voucher.code_voucher;
    this.mota = voucher.mota;
    this.phantram = voucher.phantram;
    this.loaiMA = voucher.loaiMA;
    this.soluong = voucher.soluong;
    this.diem = voucher.diem;
}

Voucher.get_all = function(result){
    db.query("SELECT * FROM Voucher", function(err, voucher){
        if(err){
            result(err);
        } else {
            result(voucher)
        }
    })
}


Voucher.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM users where id = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


Voucher.create = function(data, result) {
    db.query("insert into users set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


Voucher.remove = function(id, result) {

    db.query("delete from users where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


Voucher.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


Voucher.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}
module.exports = Voucher;