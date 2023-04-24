const inputId = document.querySelector("#inputId");
const inputPassword = document.querySelector("#inputPassword");
const loginButton = document.querySelector("#loginButton");

// id, password 길이 확인후 button disable
[inputId, inputPassword].forEach((element) => element.addEventListener("keyup", checkLength));

// login 버튼 클릭시
loginButton.addEventListener("submit", handleLogin);
function checkLength(){
    const id = inputId.value;
    const password = inputPassword.value;
    loginButton.classList.toggle("disabled", !id || password.length < 8);

}

// async function handleLogin(e){
//     e.preventDefault();
//     const id = inputId.value;
//     const password = inputPassword.value;
//     try{
//         const result = await Api.post("/api/login",data)
//     }
// }
