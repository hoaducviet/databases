var mysql = require('mysql')

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '12345678',
    database: 'mysql_res',
  })

  connection.connect(function(err) {
    if (err) { console.log('Not connected:', err) }
    else console.log('Connected to database')
})

module.exports = connection