const mongoose = require('mongoose');
const ProductSchema = require('../schemas/productSchema');

exports.Product = mongoose.model('Product', ProductSchema);