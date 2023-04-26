const cartItem = document.querySelector(".cart-item");
const purchaseBtn = document.querySelector(".purchase-btn");
const productPrice = document.querySelector(".product-price");
const productQuantity = document.querySelector(".quantity");
const cartContainer = document.querySelector(".cart-container");
const checkAll = document.getElementById("allCheck");
const totalPriceText = document.querySelector(".total-price");
const decreaseBtn = document.getElementById("decrease-btn");
const increaseBtn = document.getElementById("increase-btn");

const menu = JSON.parse(localStorage.getItem("menu"));

let totalPrice = 0;

const purchaseBtnHandler = (item) => {
  const { productName, price, quantity } = item.orderItems;
  totalPrice += Number(price) * quantity;

  const paintProduct = ` <div class="container text-left" >
<div class="row" >
  <div class="col">
    <div class="form-check">
      <input class="form-check-input painted" type="checkbox" value="" id="defaultCheck1">
      <label class="form-check-label" for="defaultCheck1">
        <p class="cart-item">${productName}</p>
      </label>
    </div>
  </div>

  <div class="col">
  <div id="itemCount">
  <button
  id="decrease-btn"
  type="button"
  class="btn btn-secondary btn-sm"
  style="height: 1.5rem"
  >
  -
  </button>
  <p class="quantity">${quantity}</p>
  <button
  id="increase-btn"
  type="button"
  class="btn btn-secondary btn-sm"
  style="height: 1.5rem"
  >
  +
  </button>
  </div>
  </div>

  <div class="col">
    <p class="product-price">${price}원</p>
  </div>
  <div class="col">
    <div>3,000원</div>
  </div>
</div>
</div>`;
  cartContainer.insertAdjacentHTML("beforeend", paintProduct);
};

menu.forEach(purchaseBtnHandler);

totalPriceText.innerText = totalPrice;

const checkBoxs = document.querySelectorAll(".form-check-input.painted");

const checkAllHandler = (e) => {
  if (e.target.checked) {
    checkBoxs.forEach((checkbox) => {
      checkbox.checked = true;
    });
  } else {
    checkBoxs.forEach((checkbox) => {
      checkbox.checked = false;
    });
  }
};

purchaseBtn.addEventListener("click", purchaseBtnHandler);
checkAll.addEventListener("change", checkAllHandler);
