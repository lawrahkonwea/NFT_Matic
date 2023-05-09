// 


// play game event
  const inputBox = document.querySelectorAll(".num-input")
  const numBtn = document.querySelectorAll(".num");
  let selectedNumbers;
  // console.log(inputBox);
 
  // select number
  let number;
  let value = Array(6).fill(null) ;

  function playGame(e) {
    number =  e.target.textContent
    for (let i = 0; i < value.length; i++) {
      if(value[i] !== null)  continue;
      value[i] = number;
      break;
    }

    inputBox.forEach((ele,idx)=> {
      ele.textContent = value[idx]
       selectedNumbers = value
    });

    
    // this.removeEventListener("click",playGame)
  }
  numBtn.forEach(num => { 
    num.addEventListener("click",() => {
    num.style.backgroundColor = "green"   
    })
      num.addEventListener("click",playGame)
      // num.style.backgroundColor = "green"
      
  });
    // get value
    
    // console.log(value);
// Game section
const gameCard = document.querySelector(".game-num");
let firstTouch;
let lastTouch;
function swipeDirection(){
    let touchDiff = firstTouch - lastTouch;
    if(touchDiff > 100) gameCard.style.marginLeft = "-60%"
    if(touchDiff < -100) gameCard.style.marginLeft = "0%"
}
  
gameCard.addEventListener("touchstart", (ev) => {
    firstTouch = ev.touches[0].screenX
})
gameCard.addEventListener("touchmove", (ev) => {
  lastTouch = ev.touches[0].screenX
  console.log(lastTouch);

  swipeDirection()

})
// Game section