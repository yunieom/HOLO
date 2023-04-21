const mongoose = require('mongoose');
const Cart = require('../db/models/cart-model'); // cart 모델 불러오기
const Product = require('../db/models/product-model'); // product 모델 불러오기
const bcrypt = require('bcrypt'); // 비밀번호 해쉬화를 위한 bcrypt 불러오기
const jwt = require('jsonwebtoken'); // jwt 토큰 사용을 위해 모듈 불러오기
const generateToken = require('../utils/jwt'); // jwt 토큰 생성 파일 불러오기
const saltRounds = 10; // bcrypt에서 사용되는 솔트 라운드 값 설정. 값이 클수록 보안성이 높지만, 처리 속도가 오래걸림.

// 카트 생성 & 카트 상품 추가
async function addToCart(userId, productId, quantity) {
    // 유저 카트 존재여부 확인
    const cart = await Cart.findOne({userId}).populate('cartItems');

    // 카트 미존재시 카트 생성
    if(!cart) {
        const newCart = new Cart({userId});
        await newCart.save();
        return addToCart(userId, productId, quantity);
    }

    // 카트 존재시 카트아이템 존재여부 확인
    const existingCartItem = cart.cartItems
        .find((item) => item.productId === productId);

    // 카트아이템 존재시 카트아이템 추가
    if (existingCartItem) {
        existingCartItem.quantity += quantity;
        await existingCartItem.save();
    } else {
        // 카트아이템 미존재시 카트아이템 생성
        const newCartItem = new CartItem({ productId, quantity });
        await newCartItem.save();
        cart.cartItems.push(newCartItem);
        await cart.save();
  }
  // 카트 가격 업데이트
  cart.totalPrice += quantity * Product.price;
  await cart.save();

  return cart;
}

// 카트 상품 삭제 (개별/다수상품 및 전체상품 삭제)
async function removeFromCart(userId, itemId = null) {
    // 유저 카트 조회
    const cart = await Cart.findOne({ userId }).populate('cartItems');
  
    if (!cart) {
      throw new Error('만드신 카트가 없습니다');
    }
  
    let totalPrice = 0;
  
    if (!itemId) {
      // 전체 상품 삭제
      // 전체 상품 삭제시 총 가격을 삭제된 상품(들)의 가격으로 업데이트
      totalPrice = cart.totalPrice; 
      cart.cartItems = [];
    } else {
      // 특정 상품 삭제
      const item = cart.cartItems.find((item) => item._id === itemId);
  
      if (!item) {
        throw new Error('상품을 찾을 수 없습니다');
      }
  
      // 카트 상품 삭제
      await item.remove();
  
      // 카트의 총 가격 = 삭제된 상품 가격만큼 감소
      totalPrice = -item.quantity * item.product.price;
    }
  
    // 카트 총 가격 업데이트
    cart.totalPrice += totalPrice;
    await cart.save();
  
    return cart;
}

// 카트 상품 수량 수정 (개별 및 다수상품)
async function updateCartItemQuantity(userId, itemId, quantity) {
    // 유저 카트 조회 
    const cart = await Cart.findOne({ userId }).populate('cartItems');
  
    if (!cart) {
        throw new Error('만드신 카트가 없습니다');
    }
  
    // 카트 상품 조회
    const item = cart.cartItems.find((item) => item._id === itemId);
  
    if (!item) {
      throw new Error('상품을 찾을 수 없습니다');
    }
  
    // 카트 상품 수량 업데이트
    const prevQuantity = item.quantity;
    item.quantity = quantity;
    await item.save();
  
    // 카트 총 가격 업데이트 
    cart.totalPrice += (quantity - prevQuantity) * item.product.price;
    await cart.save();
  
    return cart;
}

// 카트 상품 반환
async function getCartItems(userId) {
    // 유저 카트 조회
    const cart = await Cart.findOne({ userId }).populate('cartItems');
    
    if (!cart) {
      throw new Error('만드신 카트가 없습니다');
    }
  
    // 카트 상품 반환
    return cart.cartItems;
}  