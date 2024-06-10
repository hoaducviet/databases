var express = require('express');
var cors = require('cors');
const conrsWhitelist = require('./app/common/cors');
var app = express();

// Allow Cors
//app.use(cors(conrsWhitelist.conrsOptions))
app.use(cors());

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());



var managerRouter = require('./app/router/manager.router');


app.use('/', managerRouter)


port = 500
app.listen(port, (function(){
    console.log(`The new server in port ${port}`);
}))