const cartItem = document.querySelector(".cart-item");
const purchaseBtn = document.querySelector(".purchase-btn");
const productPrice = document.querySelector(".product-price");
const productQuantity = document.querySelector(".quantity");

const menu = JSON.parse(localStorage.getItem("menu"));
console.log(typeof menu);

const purchaseBtnHandler = () => {
  const { productName, price } = menu.orderItems;
  const { quantity } = menu.orderItems;

  cartItem.innerText = productName;
  productPrice.innerText = price;
  productQuantity.innerText = quantity;
};

//
// async function getItem() {}

menu.forEach(
  (item) => console.log(item)
  // const { productName, price, quantity } = orderItems;
  // cartItem.innerText = productName;
  // productPrice.innerText = price;
  // productQuantity.innerText = quantity;
);

//   // const { productName, price } = menu.orderItems;
//   // const { amount } = menu;

//   // cartItem.innerText = productName;
//   // productPrice.innerText = price;
//   // productQuantity.innerText = amount;
// };

purchaseBtn.addEventListener("click", purchaseBtnHandler);
