

// header collapsible
const toggle = document.querySelector(".menu-bar");
const close = document.querySelector(".close-bar");
const collapsible = document.querySelector(".collapsible");
toggle.addEventListener('click',()=>{
    collapsible.classList.toggle("hide");
});
close.addEventListener('click',()=>{
    collapsible.classList.toggle('hide');
})
 
const navItem = document.querySelectorAll(".nav-link");
navItem.forEach(link => {
    link.addEventListener("click", ()=>{
    collapsible.classList.toggle('hide')
    })
});

// connect wallet
const connectWallet = document.querySelector(".connect-btn");
const walletOption = document.querySelector("#connect-wallet");
const closeOpt = document.querySelector(".close-opt");
const walletLink = document.querySelectorAll(".wallet-link");
connectWallet.addEventListener("click",() => {
  walletOption.style.display = "initial"
})
closeOpt.addEventListener("click",() => {
  walletOption.style.display = "none"
})
walletLink.forEach(wallet => {
    wallet.addEventListener("click", () =>{
    walletOption.style.display = "none"
    collapsible.classList.toggle('hide')
    })
});

// connect wallet

// admin page
const admin = document.querySelector("#adminn");
console.log(admin)
admin?.addEventListener("click",(e) => {

let adminAccess = prompt("Input Access Code");
  if(adminAccess === "12345"){
    window.open("web3ladies_t-matic/admin.html","_blank")
  }else{
    alert("Opppss! Access Denied")
  }

})


