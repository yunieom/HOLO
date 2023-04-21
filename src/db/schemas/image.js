const mongoose = require('mongoose');
const { Schema } = mongoose;

const imageSchema = new Schema({
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