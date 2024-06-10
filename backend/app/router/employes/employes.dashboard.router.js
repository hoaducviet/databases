var express = require('express');
var router = express.Router();

var bookController = require('../controllers/book.controller')

router.get("/book/list", bookController.get_list)

router.get("/book/detail/:id", bookController.detail)

router.post("/book/add", bookController.add_book)
router.delete("/book/delete/:id", bookController.delete_book)
router.put("/book/update", bookController.update_book)


module.exports = router;