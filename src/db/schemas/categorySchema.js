const mongoose = require("mongoose");
const { Category } = require("../models/category-model");

const categorySchema = new mongoose.Schema(
  {
    categoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: Category,
      required: true,
      unique: true,
      index: true,
    },
    category: {
      type: String,
      required: true,
    },
    subCategory: {
      type: String,
      required: true,
    },
  },{
    timestamps: true,
  }
);

module.exports = categorySchema;
