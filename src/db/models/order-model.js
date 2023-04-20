const mongoose = require('mongoose');
const OrderSchema = require('../schemas/order');

//Order 모델 생성
exports.Order = mongoose.model('Order', OrderSchema);