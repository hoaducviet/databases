var express = require('express');
var router = express.Router();

var managerController = require('../controllers/manager.controller')

router.get("/manager/user", managerController.get_NguoiDung)
router.get("/manager/customer", managerController.get_KhachHang)
router.get("/manager/receipt", managerController.get_HoaDon)
router.get("/manager/dish", managerController.get_MonAn)
router.get("/manager/staffwaiter", managerController.get_NhanVienBan)
router.get("/manager/staffstore", managerController.get_NhanVienKho)
router.get("/manager/receivednote", managerController.get_PhieuNK)
router.get("/manager/deliverynote", managerController.get_PhieuXK)



// router.get("/book/detail/:id", managerController.detail)

// router.post("/book/add", bookController.add_book)
// router.delete("/book/delete/:id", bookController.delete_book)
// router.put("/book/update", bookController.update_book)


module.exports = router;