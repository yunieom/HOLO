const dotenv = require("dotenv");
const createError = require('http-errors');
const express = require('express');
const mongoose = require('mongoose');



mongoose.connect('mongodb://localhost:27017/HOLO', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB Connected'))
  .catch(err => console.log(err));



const app = express();


app.listen(3000); 