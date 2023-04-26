import * as Api from "../api.js";

const orderList = document.querySelector(".order-list-container");

getAllOrders();
async function getAllOrders() {
  const ordersObj = await Api.get("/api/admin/all-orders");
  renderOrders(ordersObj.ordersWithUser);
}

function renderOrders(orders) {
  orders.forEach((order) => {
    orderList.innerHTML += `  <div class="product-container">
      <div class="order-item shadow-sm p-3 bg-body-tertiary rounded">
        <div class="product-info">
          <div class="product-img">
            <!-- <img src="" alt="상품 이미지" /> -->
          </div>
          <div class="order-detail">
            <div class="order-id">
              <h5>주문번호</h5>
              <p>${order._id}</p>
            </div>
            <div class="order-user">
              <p>주문자</p>
              <p>${order.userId}</p>
            </div>
            <div class="order-date">
              <p>주문일자</p>
              <p>${order.createdAt?.split("T")[0]}</p>
            </div>
            <div class="order-info">
              <p>상품가격/개수</p>
              <p>${order.totalPrice} / ${order.orderItems.length}</p>
            </div>
          </div>
        </div>
        <div class="order-item-btn-container">
          <button type="button" class="btn btn-outline-success">
            배송 상태 수정
          </button>
          <button
            type="button"
            class="btn btn-outline-success btn-order-delete"
          >
            주문 삭제
          </button>
        </div>
      </div>
    </div>`;
  });
}
