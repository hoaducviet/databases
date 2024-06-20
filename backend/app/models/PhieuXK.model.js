const db = require('../common/connect');

const PhieuXK = function (phieuxuatkho) {
    this.id_xk = phieuxuatkho.id_xk;
    this.id_nv = phieuxuatkho.id_nv;
    this.ngayXK = phieuxuatkho.ngayXK;
}


PhieuXK.get_all = function(result){
    const query = "SELECT * FROM ViewPhieuXK"
    db.query(query, function(err, phieunhapkho){
        if(err){
            result(err);
        } else {
            result(phieunhapkho);
        }
    })
}

PhieuXK.getById = function(id_kh, result) {
    // console.log(id)
    db.query(`SELECT * FROM PhieuXK where id_kh = ${id_kh}`, function(err, phieunhapkho){
        if(err || phieunhapkho.length == 0){
            result(null);
        } else {
            result(phieunhapkho[0]);
        }
    })
}

PhieuXK.create = function(data, result) {
    db.query("insert into PhieuXK set ?", data, function(err, phieunhapkho){
        if(err){
            result(null);
        } else {
            result({id_kh: phieunhapkhoinsertId, ...data});
        }
    })
}

PhieuXK.remove = function(id_kh, result) {

    db.query("delete from PhieuNK where id = ?", id_kh, function(err, phieunhapkho){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id_kh)
        }
    })

}


PhieuXK.update = function(data, result) {

    db.query("update PhieuNK set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = PhieuXK;