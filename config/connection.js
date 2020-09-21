const mysql  = require('mysql');

// DEFINE DB PARAM
const dbConfig = {
    host : 'localhost',
    port : 3306,
    db   : 'dbbril_agen',
    user : 'root',
    pass : ''
};

// SETTING DB AND CONNECTION TO MYSQL SERVER
const connection = mysql.createConnection({
    host : dbConfig.host,
    port : dbConfig.port,
    database   : dbConfig.db,
    user : dbConfig.user,
    password : dbConfig.pass
});

module.exports = connection;
