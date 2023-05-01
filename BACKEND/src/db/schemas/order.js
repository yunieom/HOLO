const mongoose = require("mongoose");
const { Schema } = mongoose;

//주문상품 스키마
const OrderItemSchema = new Schema({
  productId: {
    type: String,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
    default: 1,
  },
  price: {
    type: Number,
    required: true,
  },
  discountRate: {
    type: Number,
    required: true,
  },
});

const OrderSchema = new Schema(
  {
    userId: {
      type: String,
      required: false,
      unique: false,
    },
    email: {
      type: String,
      required: true,
    },
    orderItems: [OrderItemSchema],
    shippingAddress: {
      type: String,
      required: true,
    },
    shippingMemo: {
      type: String,
    },
    totalPrice: {
      type: Number,
      required: true,
    },
    totalDiscount: {
      type: Number,
      required: true,
    },
    status: {
      type: String,
      required: true,
      enum: ["pending", "processing", "shipped", "delivered", "canceled"],
      default: "pending",
    },
  },
  {
    timestamps: true,
  }
);

module.exports = { OrderItemSchema, OrderSchema };
