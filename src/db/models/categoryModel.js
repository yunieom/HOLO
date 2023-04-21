const mongoose = require('mongoose');
const CategorySchema = require('../schemas/category');

//카테고리 모델 생성
exports.Category = mongoose.model('Category', CategorySchema);