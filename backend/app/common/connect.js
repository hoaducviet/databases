var mysql = require('mysql')

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'manager',
    password: 'manager123',
    database: 'mysql_res',
  })

  connection.connect(function(err) {
    if (err) { console.log('Not connected:', err) }
    else console.log('Connected to database')
})

module.exports = connection