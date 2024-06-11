const db = require('../common/connect');
const MonAn = function (monan) {
    this.id_monan = monan.id_monan;
    this.tenMon = monan.tenMon;
    this.dongia = monan.dongia;
    this.loai = monan.loai;
    this.trangthai = monan.trangthai;
}


MonAn.get_all = function(result){
    db.query("SELECT * FROM MonAn", function(err, monan){
        if(err){
            result(err);
        } else {
            result(monan)
        }
    })
}


MonAn.get_topRate = function(result){
    const query = "SELECT * FROM MonAn ORDER BY DanhGia DESC LIMIT 4"
    db.query(query, function(err, monan){
        if(err){
            result(err);
        } else {
            result(monan)
        }
    })
}


MonAn.get_topNumber = function(result){
    const query = "SELECT MonAn.ID_MonAn, MonAn.TenMon, MonAn.DonGia, MonAn.Loai, MonAn.DauBep, SUM(CTHD.SoLuong) AS SoLuong FROM MonAn JOIN CTHD ON MonAn.ID_MonAn = CTHD.ID_MonAn GROUP BY MonAn.ID_MonAn ORDER BY SoLuong DESC LIMIT 4"
    db.query(query, function(err, monan){
        if(err){
            result(err);
        } else {
            result(monan)
        }
    })
}


MonAn.getById = function(id, result) {
    console.log(id)
    db.query(`SELECT * FROM MonAn where id = ${id}`, function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}


MonAn.create = function(data, result) {
    db.query("insert into MonAn set ?", data, function(err, user){
        if(err){
            result(null);
        } else {
            result({id: user.insertId, ...data});
        }
    })
}


MonAn.remove = function(id, result) {

    db.query("delete from MonAn where id = ?", id, function(err, user){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id)
        }
    })

}


MonAn.update = function(data, result) {

    db.query("update users set name=?, email=?, password=?  where id=?", [data.name, data.email, data.password], function(err, user){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}


MonAn.check_login = function(data, result) {
    db.query(`SELECT * FROM users where email=? and password=?`,[data.email, data.password], function(err, user){
        if(err || user.length == 0){
            result(null);
        } else {
            result(user[0]);
        }
    })
}
module.exports = MonAn;