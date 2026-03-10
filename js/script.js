console.log("Website Loaded");


window.addEventListener("scroll",function(){

let nav = document.querySelector(".navbar");

if(window.scrollY > 50){
nav.classList.add("shadow");
}else{
nav.classList.remove("shadow");
}

});