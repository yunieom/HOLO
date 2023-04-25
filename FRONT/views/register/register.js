import * as Api from "../../api/api.js";

const inputId = document.querySelector("#inputId");
const idConfirmButton = document.querySelector("#idConfirmButton");
const inputPassword = document.querySelector("#inputPassword");
const inputPasswordConfirm = document.querySelector("#inputPasswordConfirm");
const inputName = document.querySelector("#inputName");
const inputPhone = document.querySelector("#inputPhone");
const inputAddress = document.querySelector("#inputAddress");
const addressFindButton = document.querySelector("#addressFindButton");
const inputDetailedAddress = document.querySelector("#inputDetailedAddress");
const inputEmail = document.querySelector("#inputEmail");

function disableConfirmButton(){
    const id = inputId.value;
    idConfirmButton.classList.toggle("disabled", !id);
}
async function handleIdConfirm(e){
    e.preventDefault();
    const userId = inputId.value;
    try{
        const result = await Api.post("/api/users/check-userid", userId);
    }catch{

    }
}
// id 입력 전에 중복확인 버튼 비활성화
inputId.addEventListener("keyup", disableConfirmButton);
// 중복확인 버튼 클릭시
idConfirmButton.addEventListener("click", handleIdConfirm);