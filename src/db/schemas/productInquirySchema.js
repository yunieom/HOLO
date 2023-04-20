const mongoose = require("mongoose");
const { Product } = require("../models/product-model");
const { User } = require("../models/user-model");

const productInquirySchema = new mongoose.Schema(
  {
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: Product,
      required: true,
      index: true,
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: User,
      required: true,
    },
    inquiryNum: {
      type: Number,
      required: true,
      unique: true,
    },
    date: {
      type: Date,
      required: true,
      default: Date.now,
    },
    answerStatus: {
      type: Boolean,
      required: true,
      default: false,
    },
    inquiryTitle: {
      type: String,
      required: true,
    },
    inquiryContent: {
      type: String,
      required: true,
    },
    publicStatus: {
      type: Boolean,
      required: true,
      default: true,
    },
    password: {
      type: String,
    },
  },{
    timestamps: true,
  }
);

module.exports = mongoose.model("ProductInquiry", productInquirySchema);
