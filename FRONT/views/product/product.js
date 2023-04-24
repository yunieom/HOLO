const addCartItemBtn = document.getElementById("add-cart-item-btn");

const productPrice = () => {};
const productName = () => {};
const discountRate = () => {};
const shortDesc = () => {};
const longDesc = () => {};
const imageUrl = () => {};
const stock = () => {};

let menu = {
  product,
  amount,
};

const addCartItemBtnHandler = () => {
  window.localStorage.setItem("menu");
};

addCartItemBtn.addEventListener("click", addCartItemBtnHandler);
