const { Schema } = require('mongoose');

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