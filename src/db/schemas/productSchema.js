const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    productId: {
      type: String,
      required: true,
      unique: true,
      index: true,
    },
    productName: {
      type: String,
      required: true,
    },
    categoryId: {
      type: String,
      required: true,
      unique: true,
      index: true,
      trim: true,
    },
    price: {
      type: Number,
      required: true,
    },
    discountRate: {
      type: Number,
      required: true,
    },
    shortDesc: {
      type: String,
      required: true,
    },
    longDesc: {
      type: String,
    },
    imageUrl: [
      {
        type: String,
        required: true,
      },
    ],
    bigImageUrl: {
      type: String,
      required: true,
    },
    purchaseNum: {
      type: Number,
      required: true,
    },
    stock: {
      type: Number,
      required: true,
      default: 10,
    },
    productStatus: {
      type: Boolean,
      required: true,
      default: true,
    },
    originLabel: {
      type: String,
    },
  },{
    timestamps: true,
  }
);

module.exports = mongoose.model("Product", productSchema);
