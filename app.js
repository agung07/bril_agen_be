const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const controller = require('./controllers');
const connection = require('./config/connection');



const app = express();

//SET UP TEMPLATE ENGINE
app.set('view engine', 'ejs');

//Midleware
app.use(cors());  //ALLOW CORS
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json());


//Routess
controller(app, connection);


//LISTEN PORT
const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log(`Server is runningin port : ${PORT}`));