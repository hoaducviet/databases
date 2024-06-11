const db = require('../common/connect');
const PhieuNK = function (phieunhapkho) {
    this.id_nk = phieunhapkho.id_nk;
    this.id_nv = phieunhapkho.id_nv;
    this.ngayNK = phieunhapkho.ngayNK;
    this.tongtien = phieunhapkho.tongtien;
   
}


PhieuNK.get_all = function(result){
    const query = "SELECT PhieuNK.ID_NK, NhanVienKho.TenNV, PhieuNK.NgayNK, PhieuNK.Tongtien FROM PhieuNK JOIN NhanVienKho ON PhieuNK.ID_NV = NhanVienKho.ID_NV"
    db.query(query, function(err, phieunhapkho){
        if(err){
            result(err);
        } else {
            result(phieunhapkho);
        }
    })
}

PhieuNK.getById = function(id_kh, result) {
    // console.log(id)
    db.query(`SELECT * FROM PhieuNK where id_kh = ${id_kh}`, function(err, phieunhapkho){
        if(err || phieunhapkho.length == 0){
            result(null);
        } else {
            result(phieunhapkho[0]);
        }
    })
}

PhieuNK.create = function(data, result) {
    db.query("insert into PhieuNK set ?", data, function(err, phieunhapkho){
        if(err){
            result(null);
        } else {
            result({id_kh: phieunhapkhoinsertId, ...data});
        }
    })
}

PhieuNK.remove = function(id_kh, result) {

    db.query("delete from PhieuNK where id = ?", id_kh, function(err, phieunhapkho){
        if(err){
            result(null);
        } else {
            result("Xoa thanh cong id " + id_kh)
        }
    })

}


PhieuNK.update = function(data, result) {

    db.query("update PhieuNK set email=?, matkhau=?, trangthai=? vaitro =? where id_nd=?", [data.email, data.matkhau, data.trangthai, data.vaitro, data.id_nd], function(err, book){
        if(err){
            result(null);
        } else {
            result(data)
        }
    })
}

module.exports = PhieuNK;