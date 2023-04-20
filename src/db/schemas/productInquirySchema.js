const mongoose = require("mongoose");

const productInquirySchema = new mongoose.Schema(
  {
    productId: {
      type: String,
      required: true,
      index: true,
    },
    userId: {
      type: String,
      required: true,
    },
    inquiryId: {
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
