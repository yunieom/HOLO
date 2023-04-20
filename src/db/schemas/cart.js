const { Schema } = require('mongoose');

const { Cart } = require('./models');
//장바구니 아이템은 장바구니에 담긴 물건이 하나 이상일 수 있기 때문에 먼저 상품과 수량을 받습니다. 
const cartItemSchema = new Schema({
  productId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product',
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
    default: 1,
  },
});

const cartSchema = new Schema({
    cardId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Cart',
        required: true,
    },
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true, 
    },
    items: [cartItemSchema],
    totalPrice: {
        type: Number,
        required: true,
        default: 0,
    },
    createdAt: {
        type: Date,
        default: Date.now,
        required: true,
    },
});



module.exports = {cartSchema, cartItemSchema};
module.exports = CartSchema;