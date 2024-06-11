const db = require('../common/connect');
const Kho = function (kho) {
    this.id_nl = kho.id_xk;
    this.slTon = kho.slTon;

}


Kho.get_all = function(result){
    const query = "SELECT NguyenLieu.ID_NL, NguyenLieu.TenNL, NguyenLieu.DonGia, NguyenLieu.DonViTinh, Kho.SLTon FROM NguyenLieu JOIN Kho ON NguyenLieu.ID_NL = Kho.ID_NL"
    db.query(query, function(err, kho){
        if(err){
            result(err);
        } else {
            result(kho)
        }
    })
}


Kho.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM CTHD where id_hoadon = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


Kho.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


Kho.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


Kho.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


Kho.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}

module.exports = Kho;