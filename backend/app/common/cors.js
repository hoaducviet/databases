// Dùng để cho phép các domain khác truy cập từ frontend tới backend khi không có cùng địa chỉ IP


const whitelist = [
  'http://localhost:3000',
  'http://localhost:500',
  'http://localhost:8000',

]

exports.conrsOptions = {
    origin: function (origin, callback) {
        if (whitelist.indexOf(origin) !== -1) {
          callback(null, true)
        } else {
          callback(new Error('Not allowed by CORS'))
        }
      }
}

