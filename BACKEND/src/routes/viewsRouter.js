const express = require("express");
const { Router } = require("express");
const viewsRouter = Router();
const path = require("path");

// 페이지별로 html, css, js 파일들 라우팅
viewsRouter.use("/", serveStatic("home"));

viewsRouter.use("/register", serveStatic("register"));
viewsRouter.use("/login", serveStatic("login"));
viewsRouter.use("/payment", serveStatic("payment"));
viewsRouter.use("/product", serveStatic("product"));
viewsRouter.use("/productList", serveStatic("productList"));
viewsRouter.use("/shoppingCart", serveStatic("shoppingCart"));
viewsRouter.use("/logout", serveStatic("logout"));
viewsRouter.use("/order-completed", serveStatic("order-completed"));
viewsRouter.use("/findorder", serveStatic("findorder"));

viewsRouter.use("/adminpage/product", serveAdminStatic("product"));
viewsRouter.use("/adminpage/user", serveAdminStatic("user"));
viewsRouter.use("/adminpage/order", serveAdminStatic("order"));

viewsRouter.use("/mypage/order", serveUserStatic("order"));
viewsRouter.use("/mypage/modify", serveUserStatic("modify"));

viewsRouter.use("/public/images", serveImage("/"));

// views 폴더의 최상단 파일 (사진, favicon 등) 라우팅
viewsRouter.use("/", serveStatic(""));

function serveStatic(resource) {
  const resourcePath = path.join(__dirname, `../../../FRONT/views/${resource}`);
  const option = { index: `${resource}.html` };

  return express.static(resourcePath, option);
}

function serveAdminStatic(resource) {
  const resourcePath = path.join(
    __dirname,
    `../../../FRONT/views/adminpage/admin-${resource}.html`
  );
  const option = { index: `admin-${resource}.html` };

  return express.static(resourcePath, option);
}

function serveUserStatic(resource) {
  const resourcePath = path.join(
    __dirname,
    `../../../FRONT/views/mypage/mypage-${resource}.html`
  );
  const option = { index: `mypage-${resource}.html` };

  return express.static(resourcePath, option);
}

function serveImage(resource) {
  const resourcePath = path.join(__dirname, `../../../public/images`);
  const option = { index: `${resource}` };

  return express.static(resourcePath, option);
}

module.exports = viewsRouter;
