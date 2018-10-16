// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .

function setImages(bg) {
  var mast = document.querySelector("header.masthead");
  mast.style.background = bg;
  mast.style.backgroundSize = "100%";
  var call = document.querySelector("section.call-to-action");
  call.style.background = bg;
  call.style.backgroundSize = "100%";

}

window.onload = function() {
  var webp = new Image();
  webp.onerror = function(){
    setImages("url('/pexelsbg.png') no-repeat center center");
    console.log('Your browser does not support WebP');
  };
  webp.onload = function(){
    setImages("url('/pexelsbg.webp') no-repeat center center");
  };
  webp.src = 'data:image/webp;base64,UklGRjIAAABXRUJQVlA4ICYAAACyAgCdASoBAAEALmk0mk0iIiIiIgBoSygABc6zbAAA/v56QAAAAA==';

}

