const { Schema } = require('mongoose');


const imageSchema = new Schema({
  imageUrl: {
    type: String,
    required: true,
  },
  thumbnailUrls: [
    {
      type: String,
      required: true,
    },
  ],
});

const productSchema = new Schema({
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product',
      required: true,
    },
    productName: {
      type: String,
      required: true,
    },
    categoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Category',
      required: true,
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
    image: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Image',
        required: true,
      },
    ],
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
  },
  {
    timestamps: true,
  });


