console.log("CMS Orlando 0.1_01");

// this software lies on YAC:
if (yac_version < 0.1) {alert('Unsuported YAC version: ' + yac_version);}

var yac_default = 'localhost/yac';

// the page structure
var header    = {};
var body      = {};
var leftPane  = {};
//var rightPane = {};
var footer    = {};
var menu      = {};

// on jquery load
$(function(){

   header    = new MyHead();
   body      = new MyBody();
   leftPane  = new MyLeftPane();
   //rightPane = new MyRightPane();
   footer    = new MyFooter();
   menu      = new MyMenu();

   ////////////////////////////////////////////////////////
   /** inicia o site
   */

   // Monta a tela
   montaTela();
   // Cria o mapa
   //doMap('bodyContainer');
   // load the content in body
   //body.setContent(yac_default);

   // Sensibilidade do menu
   $(".menu").hover(
     function () {
       $(this).css('color', '#c0c0c0');
     },
     function () {
       $(this).css('color', '#6c6d6f');
     }
   );

   // Links do menu
   $(".menu").mousedown(function() {
      var act = $(this).attr('id');
      switch (act)
     {
     case 'menu_0':
       body.setContent("http://kobkob.com.br/");
       break;
     case 6:
       alert('chamou: '+ $(this).attr('id'));
       break;
     case 0:
       alert('chamou: '+ $(this).attr('id'));
       break;
     default:
       alert('chamou: '+ $(this).attr('id'));
     }
   });

   // Dialog
   /*
   $('#janela').dialog({
       autoOpen: false,
       width: 400,
   });
  //$('#bodyFrame').attr('src', "/vivaorlando/index.php/blog/welcome");
   */


   // Carrega a oferta do momento a cada 13 segundos
   // FIXME passar o 13 para o settimeout !!!!
   //frameOfertas(0,13000);


});

// Google map
var map       = '';
var myLatlng  = {};
var myOptions = {};
//http://maps.google.com/cbk?output=xml&ll=28.42403,-81.404093&cb_client=maps_sv

function doMap(map_id){
    myLatlng = new google.maps.LatLng(28.42403,-81.404093);
    myOptions = {
      zoom: 8,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById(map_id), myOptions);
    console.log ('Map -> '); console.log(map);
}

function reloadMap(){
    setTimeout("document.getElementById('gmaps').src=document.getElementById('gmaps').src;", 1000);
}

function montaTela(){
  // the screen sizes
  var frW = pageWidth();
  var frH = pageHeight();
  console.log('My screen -> ' + frW + " : " + frH);

  // scale to fit screen
  var k = frW/$('#header').width() - 0.008;
  console.log('header width -> ' + $('#header').width());
  console.log('scale factor -> ' + k);

  header.setId('header');
  header.scale(k);

  menu.setId('menu*');
  menu.scale(k);

  body.setId('bodyContainer');
  body.scale(k);

  leftPane.setId('leftImage');
  leftPane.scale(k);

  //rightPane.setId('bodyContainer');
  //rightPane.scale(k);

  footer.setId('footer');
  footer.scale(k);

  $('#gmaps').attr('width',($('#gmaps').width() * k));
  $('#gmaps').attr('height',($('#gmaps').height() * k));
}

var refresh = 0;
function frameOfertas(tempo, oferta)
{
  var noferta = 0;
  while (noferta == 0 ) {
    console.log (refresh + " -> refresh");
    if (!oferta) oferta = 0;
    refresh ++;
    noferta=setTimeout("updateOfertas(" + oferta + ")",tempo);
    console.log(noferta);
  }
}

function updateOfertas(oferta) {
    //$('#oferta').load('?/taonde/taqui/'+coisa);
    console.log(oferta);

}

// Common functions
////////////////////////////////////////////////////

var janelaAberta=0;
function abreJanela(){
   if (!janelaAberta){
       $('#janela').dialog('open');
       janelaAberta++;
       setTimeout("fechaJanela()",9000);
   }
}

function fechaJanela(){
    if (janelaAberta){
   janelaAberta = 0;
   $('#janela').dialog('close');
    }
}

function pageWidth() {
    return window.innerWidth != null? window.innerWidth : document.documentElement && document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body != null ? document.body.clientWidth : null;
}

function pageHeight() {
    return  window.innerHeight != null? window.innerHeight : document.documentElement && document.documentElement.clientHeight ?  document.documentElement.clientHeight : document.body != null? document.body.clientHeight : null;
}

function posLeft() {
    return typeof window.pageXOffset != 'undefined' ? window.pageXOffset :document.documentElement && document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft ? document.body.scrollLeft : 0;
}

function posTop() {return typeof window.pageYOffset != 'undefined' ?  window.pageYOffset : document.documentElement && document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop ? document.body.scrollTop : 0;
}

function posRight() {
    return posLeft()+pageWidth();
}

function posBottom() {
    return posTop()+pageHeight();
}

//////////////////////////////////////////////////////////


