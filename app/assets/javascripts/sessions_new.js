window.onload = function(){
  //var url = "a.jpg".split(',');
  var url=[];
  url[0] = 'jazz.jpg';
  url[1] = 'classical.jpg';
  url[2] = 'drums.jpg';
  url[3] = 'guitar.jpg';
  url[4] = 'rapper.jpg';
  url[5] = 'edm.jpg';
  url[6] = 'shop2.jpg';
  url[7] = 'headphones_pink.jpg';
  url[8] = 'woman.jpg';
  var n = Math.floor(Math.random() * url.length);
  var elm = document.getElementById('devise-sessions-container');
  elm.style.backgroundImage = 'url(/images/' + url[n] + ')';
}