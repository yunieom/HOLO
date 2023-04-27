const { Router } = require("express");
const router = Router();
const productService = require('../service/productService');
const isAdmin = require('../middlewares/isAdmin');

// ********** 관리자 페이지 입니다. **********
// 관리자 카테고리 추가, 됨
router.post("/admin/category", async (req, res) => {
    try {
        const result = await productService.addCategory(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 관리자 카테고리 수정, 됨
router.patch("/admin/category/:categoryId",isAdmin, async (req, res) => {
    try {
        const result = await productService.updateCategory(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 관리자 카테고리 삭제, 됨
router.delete("/admin/category/:categoryId", async (req, res) => {
    try {
        const result = await productService.deleteCategory(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 관리자 상품 추가, 됨
router.post('/admin', isAdmin, async (req, res) => {
    try {
        const result = await productService.addProduct(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 관리자 상품 수정, 됨
router.patch("/admin/:productId", async (req, res) => {
    try {
        const result = await productService.updateProduct(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 관리자 상품 삭제, 됨
router.delete("/admin/:productId", async (req, res) => {
    try {
        const result = await productService.deleteProduct(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// ********** 사용자 관련 페이지 입니다. **********
// 사용자 카테고리목록 조회, 됨
router.get("/", async (req, res) => {
    try {
        const result = await productService.getCategoryList(req, res);
        res.json(result);
    } catch (err) {
        console.log(err);
        res.status(400).json({ message: err.message });
    }
});

// 사용자 카테고리별 상품 조회, 됨
// categoryId는 육류, 채소류 등등 입니다.
router.get("/category/:categoryId", async (req, res) => {
  try {
      const result = await productService.getProductList(req, res);
      res.json(result);
  } catch (err) {
      console.log(err);
      res.status(400).json({ message: err.message });
  }
});

// 사용자 할인상품 조회
router.get("/discount", async (req, res) => {
  try {
      const result = await productService.getDiscountedProducts(req, res);
      res.json(result);
  } catch (err) {
      console.log(err);
      res.status(400).json({ message: err.message });
  }
});

// 사용자 인기상품 조회
router.get("/popular", async (req, res) => {
  try {
      const result = await productService.getPopularProducts(req, res);
      res.json(result);
  } catch (err) {
      console.log(err);
      res.status(400).json({ message: err.message });
  }
});

// 사용자 상품 상세페이지
router.get("/:productId", async (req, res) => {
  try {
      const result = await productService.getProductDetail(req, res);
      res.json(result);
  } catch (err) {
      console.log(err);
      res.status(400).json({ message: err.message });
  }
});

module.exports = router;

