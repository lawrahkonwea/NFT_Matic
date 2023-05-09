let provider = new ethers.providers.Web3Provider(window.ethereum)


let accArea = document.getElementById("accountArea");
accArea.innerHTML = JSON.parse(sessionStorage.getItem("address")) || "Connect Wallet";

// connect metamask
const connectMetamask = async () =>{
    let walletOption = document.getElementById("connect-wallet")
    if(window.ethereum !== "undefined"){
        let account;
        const accounts = await ethereum.request({method: "eth_requestAccounts"});
         account = accounts[0];  
         let cc =   `${account.slice(0,account.length-37)}...${account.slice(36)}`
         sessionStorage.setItem("address", JSON.stringify(cc));
    accArea.innerHTML = JSON.parse(sessionStorage.getItem("address")) || "Connect Wallet";

           walletOption.style.display = "none"           
    }
}

  
// let isMetaMaskConnected = () => ethereum.isConnected()
// // Connect Metamask with Dapp
// const connectMetamask = async () => {
//     try {
//         let account = await ethereum.request({method: 'eth_requestAccounts'})
//         const signer = provider.getSigner();
//         accArea.innerHTML = account
//         return account
//     }catch (error) {
//         alert('Error Connecting to metamask account:/n',error)
//         return error
//     }
// }


