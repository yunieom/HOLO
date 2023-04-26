const cartItem = document.querySelector(".cart-item");
const purchaseBtn = document.querySelector(".purchase-btn");
const cartContainer = document.querySelector(".cart-container");
const checkAll = document.getElementById("allCheck");
const totalPriceText = document.querySelector(".total-price");
const decreaseBtn = document.querySelector(".decrease-btn");
const increaseBtn = document.querySelector(".increase-btn");
const menu = JSON.parse(localStorage.getItem("menu"));

let totalPrice = 0;

const paintCart = (item) => {
  const { productName, price, quantity } = item.orderItems;
  totalPrice += Number(price) * quantity;

  const paintProduct = ` <div class="container text-left li" >
  <div class="row">
  <div class="col">
  <div class="form-check">
  <input class="form-check-input painted" type="checkbox" id="defaultCheck1">
  <label class="form-check-label" for="defaultCheck1">
  <p class="cart-item">${productName}</p>
  </label>
  </div>
  </div>
  
  <div class="col">
  <div class="item-count">
  <button
  type="button"
  class="btn btn-secondary btn-sm decrease-btn"
  style="height: 1.5rem"
  >
  -
  </button>
  <p class="quantity">${quantity}</p>
  <button
  type="button"
  class="btn btn-secondary btn-sm increase-btn"
  style="height: 1.5rem"
  >
  +
  </button>
  </div>
  </div>
  
  <div class="col">
  <p class="product-price" >${price}</p>
  </div>
  <div class="col">
  <div>3,000원</div>
  </div>
  </div>
  </div>`;
  cartContainer.insertAdjacentHTML("beforeend", paintProduct);
};

menu.forEach(paintCart);

// const productQuantity = document
//   .querySelectorAll(".item-count")
//   .forEach((el) => {
//     // item-count, decrease, increase
//     let quantity = el.querySelector(".quantity");
//     let productPrice = document.querySelector(".product-price");
//     console.log(typeof productPrice);
//     el.addEventListener("click", (e) => {
//       // console.log(e.target.classList.contains("increase-btn"));
//       if (e.target.classList.contains("increase-btn")) {
//         quantity.innerText = Number(quantity.innerText) + 1;
//         productPrice.innerText =
//           Number(productPrice.innerText) * quantity.innerText;
//       } else {
//         if (quantity.innerText > 1) {
//           quantity.innerText = Number(quantity.innerText) - 1;
//         }
//       }
//     });
//   });

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

const purchaseBtnHandler = (e) => {
  if (e.target.checked == False) {
  } else {
  }
  // 1. 현재 선택된 장바구니 정보 가져오기
  // 2. 주문 데이터로 저장
  // 3. 결제페이지로 이동
};

// const decreaseBtnHandler = () => {
//   if (quantity.innerText > 1) {
//     quantity.innerText = Number(quantity.innerText) - 1;
//     productQuantity -= 1;
//     totalPrice.innerText = quantity.innerText * price.innerText;
//   }
// };

const increaseBtnHandler = (el, originPrice) => {
  let quantity = el.querySelector(".quantity");
  let productPrice = el.querySelector(".product-price");

  quantity.innerText = Number(quantity.innerText) + 1;
  productPrice.innerText = originPrice * Number(quantity.innerText);
};

const decreaseBtnHandler = (el, originPrice) => {
  let quantity = el.querySelector(".quantity");
  let productPrice = el.querySelector(".product-price");

  if (quantity.innerText > 1) {
    quantity.innerText = Number(quantity.innerText) - 1;
    productPrice.innerText = originPrice * Number(quantity.innerText);
  }
};

purchaseBtn.addEventListener("click", purchaseBtnHandler);
checkAll.addEventListener("change", checkAllHandler);

const productLi = document.querySelectorAll(".container.text-left.li");

productLi.forEach((el) => {
  const originPrice = Number(el.querySelector(".product-price").innerText);

  el.addEventListener("click", (e) => {
    if (e.target.classList.contains("increase-btn")) {
      increaseBtnHandler(el, originPrice);
    } else if (e.target.classList.contains("decrease-btn")) {
      decreaseBtnHandler(el, originPrice);
    }
  });
});

// TODO

// 삭제하기 버튼 click => 체크된 상품 삭제하기
// 상품 금액
