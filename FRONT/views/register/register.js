import * as Api from "../api.js";

const inputId = document.querySelector("#inputId");
const idConfirmButton = document.querySelector("#idConfirmButton");
const inputPassword = document.querySelector("#inputPassword");
const inputPasswordConfirm = document.querySelector("#inputPasswordConfirm");
const inputName = document.querySelector("#inputName");
const inputPhone = document.querySelector("#inputPhone");
const inputAddress = document.querySelector("#address");
const inputDetailedAddress = document.querySelector("#detailAddress");
const inputEmail = document.querySelector("#inputEmail");
const registerButton = document.querySelector("#registerButton");
const termAgreement = document.querySelector("#termAgreement");
const registerForm = document.querySelector("#registerFormWrapper");
const isLogin = sessionStorage.getItem('token');

// 로그인상태면 메인으로 넘기기
if(isLogin){
    window.location.href = '/'
    alert('잘못된 접근입니다');
}
// id 입력 안하면 중복확인 버튼 비활성화
function disableConfirmButton() {
    const id = inputId.value;
    idConfirmButton.classList.toggle("disabled", !id || inputId.readOnly);
}

// id 중복확인 여부
let idDuplicated = true;

// id 중복확인 api 호출
async function handleIdConfirm(e) {
    e.preventDefault();
    const userId = inputId.value;
    const data = {userId};
    try {
        const result = await Api.post("/api/users/check-userid", data)
        if (result.isDuplicated) {
            alert(result.message);
        } else {
            // 중복되지 않은 아이디인 경우 id input과 button 비활성화
            alert(result.message);
            idDuplicated = false;
            inputId.disabled = true;
            idConfirmButton.classList.toggle("disabled");
        }
    } catch {
        alert("잘못된 아이디입니다");
    }
}

// 회원가입 api 호출
async function handleRegister(e) {
    e.preventDefault();
    if (idDuplicated) {
        alert("아이디 중복확인을 해주세요");
        return;
    }
    const password = inputPassword.value;
    const confirmPassword = inputPasswordConfirm.value;
    if (password !== confirmPassword) {
        alert("비밀번호가 비밀번호 확인과 갈지 않습니다");
        return;
    }
    const userId = inputId.value;
    const name = inputName.value;
    const phoneNumber = inputPhone.value.replace(/[^0-9]/g, '');
    const address = inputAddress.value + inputDetailedAddress.value;
    const email = inputEmail.value;
    const termsAgreed = termAgreement.checked;
    const data = {userId, password, address, email, phoneNumber, isAdmin: false, name, termsAgreed};
    try {
        const result = await Api.post("/api/users/register", data);
        alert(`${result.user.name}님, 회원가입이 완료되었습니다!`);
        window.location.href = "/login";
    } catch (err) {
        alert(err.message);
    }
}

// 엔터키로 중복확인 제출 방지
function pressEnter(e) {
    if (e.code === 'Enter') {
        e.preventDefault();
        registerButton.click();
    }
}
// 핸드폰번호 자동 하이픈
function autoHypenPhone(e) {
    let str = e.target.value;
    str = str.replace(/[^0-9]/g, '');
    let tmp = '';
    if (str.length < 4) {
        e.target.value = str;
    } else if (str.length < 8) {
        e.target.value = `${str.slice(0, 3)}-${str.slice(3)}`
    } else {
        e.target.value = `${str.slice(0, 3)}-${str.slice(3, 7)}-${str.slice(7)}`
    }
}

// id 입력 전에 중복확인 버튼 비활성화
inputId.addEventListener("keyup", disableConfirmButton);
// 중복확인 버튼 클릭시
idConfirmButton.addEventListener("click", handleIdConfirm);
// 회원가입 버튼 클릭시
registerButton.addEventListener("click", handleRegister);
// 엔터키를 회원가입 버튼에
registerForm.addEventListener("keydown", pressEnter);
// 핸드폰번호 자동 하이픈
inputPhone.addEventListener("keyup", autoHypenPhone);