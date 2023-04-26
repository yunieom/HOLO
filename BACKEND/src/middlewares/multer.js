const multer = require("multer");
const path = require("path");
const fs = require("fs");
const { v4: uuidv4 } = require("uuid");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/images");
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    const filename = uuidv4() + ext;
    cb(null, filename);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = ["jpg", "jpeg", "png", "gif"];
  const fileType = path.extname(file.originalname).substring(1).toLowerCase();

  if (allowedTypes.includes(fileType)) {
    req.fileValidationError = null;
    cb(null, true);
  } else {
    req.fileValidationError = "jpg,jpeg,png,gif 파일 업로드만 가능합니다.";
    cb(null, false);
  }
};

const imgUpload = multer({
  storage: storage,
  limits: { fileSize: 20 * 1024 * 1024 },
  fileFilter: fileFilter,
});

module.exports = { imgUpload };
