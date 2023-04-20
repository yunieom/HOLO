const mongoose = require("mongoose");

const imageSchema = new mongoose.Schema({
  imageUrl: {
    type: String,
    required: true
  },
  thumbnailUrls: [
    {
      type: String,
      required: true,
    },
  ],
});

module.exports = imageSchema;