const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema(
  {
    categoryId: {
      type: String,
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

module.exports = mongoose.model("Category", categorySchema);
