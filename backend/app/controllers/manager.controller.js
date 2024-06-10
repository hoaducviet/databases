var NguoiDung = require('../models/NguoiDung.model');
var KhachHang = require('../models/KhachHang.model');
var HoaDon = require('../models/HoaDon.model');
var MonAn = require('../models/MonAn.model');
var NhanVienBan = require('../models/NhanVienBan.model');
var NhanVienKho = require('../models/NhanVienKho.model');
var PhieuNK = require('../models/PhieuNK.model');
var PhieuXK = require('../models/PhieuXK.model');

exports.get_NguoiDung = function(req, res){
    NguoiDung.get_all(function(data){
        res.send({data})
    })
}


exports.get_KhachHang = function(req, res){
    KhachHang.get_all(function(data){
        res.send({data})
    })
}


exports.get_HoaDon = function(req, res){
    HoaDon.get_all(function(data){
        res.send({data})
    })
}


exports.get_MonAn = function(req, res){
    MonAn.get_all(function(data){
        res.send({data})
    })
}


exports.get_NhanVienBan = function(req, res){
    NhanVienBan.get_all(function(data){
        res.send({data})
    })
}


exports.get_NhanVienKho = function(req, res){
    NhanVienKho.get_all(function(data){
        res.send({data})
    })
}


exports.get_PhieuNK = function(req, res){
    PhieuNK.get_all(function(data){
        res.send({data})
    })
}


exports.get_PhieuXK = function(req, res){
    PhieuXK.get_all(function(data){
        res.send({data})
    })
}






exports.detail = function(req, res){
    Book.getById(req.params.id, function(respnse){
        res.send({result: respnse})
    })
}

exports.add_book = function(req, res){
    data = req.body
    Book.create(data, function(respnse){
        res.send({result: respnse})
    })
}

exports.delete_book = function(req, res){
    var id = req.params.id
    Book.remove(id, function(respnse){
        res.send({result: respnse})
    })
}


exports.update_book = function(req, res){
    var data = req.body
    Book.update(data, function(respnse){
        res.send({result: respnse})
    })
}