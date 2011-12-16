// sd88 template
// © Monsenhor Ricardo Filipo 2011 - Orlando, FL
// Artistic License
// require: jquery 1.4.4

var my_url = window.location.pathname;

/* GIMP Preload images: */
    images_menu = new Array();
    images_menu["0_1_plain"] = new  Image();
    images_menu["0_1_plain"].src = "/templates/SD88/images/menu_0_1.png";
    images_menu["0_1_hover"] = new  Image();
    images_menu["0_1_hover"].src = "/templates/SD88/images/menu_0_1_hover.png";
    images_menu["0_3_plain"] = new  Image();
    images_menu["0_3_plain"].src = "/templates/SD88/images/menu_0_3.png";
    images_menu["0_3_hover"] = new  Image();
    images_menu["0_3_hover"].src = "/templates/SD88/images/menu_0_3_hover.png";
    images_menu["0_5_plain"] = new  Image();
    images_menu["0_5_plain"].src = "/templates/SD88/images/menu_0_5.png";
    images_menu["0_5_hover"] = new  Image();
    images_menu["0_5_hover"].src = "/templates/SD88/images/menu_0_5_hover.png";
    images_menu["0_7_plain"] = new  Image();
    images_menu["0_7_plain"].src = "/templates/SD88/images/menu_0_7.png";
    images_menu["0_7_hover"] = new  Image();
    images_menu["0_7_hover"].src = "/templates/SD88/images/menu_0_7_hover.png";

function exchange (image, images_array_name, event)
  {
    name = image.name;
    images = eval (images_array_name);

    switch (event)
      {
        case 0:
          image.src = images[name + "_plain"].src;
          break;
        case 1:
          image.src = images[name + "_hover"].src;
          break;
        case 2:
          image.src = images[name + "_clicked"].src;
          break;
        case 3:
          image.src = images[name + "_hover"].src;
          break;
      }

  }


///////////////////////////////////////////////////////
/**
 * Menus
 * based on tips from http://javascript-array.com/
 */

var fadetime    = 1000;
var timeout     = 500;
var closetimer  = null;
var ddmenuitem  = null;

// init menu number
function initmenu(num){
       $('#submenu_'+num).hide();
       $('#menu_'+num).click(function(e) {
          mopen('#submenu_'+num);
       });
       $('#menu_'+num).mouseover(function(e) {
          mopen('#submenu_'+num);
       });
      $('#menu_'+num).mouseout(function(e) {
          mclosetime();
       });
       $('#submenu_'+num).mouseout(function(e) {
          mclosetime();
       });
       $('#submenu_'+num).mouseover(function(e) {
          mcancelclosetime();
       });
}

// open hidden layer
function mopen(id)
{
        // cancel close timer
        mcancelclosetime();

        if(ddmenuitem){
               // donut if menu is visible
               if (ddmenuitem.selector == id) return false;
               // close old layer
               ddmenuitem.fadeOut(fadetime);
        }
        // get new layer and show it
        ddmenuitem = $(id);
        ddmenuitem.fadeIn(fadetime);

}

// close showed layer
function mclose()
{
        if(ddmenuitem) ddmenuitem.fadeOut(fadetime);
        ddmenuitem = null;
}

// go close timer
function mclosetime()
{
        closetimer = window.setTimeout(mclose, timeout);
}

// cancel close timer
function mcancelclosetime()
{
        if(closetimer)
        {
                window.clearTimeout(closetimer);
                closetimer = null;
        }
}

// close layer when click-out
//document.onclick = mclose;

/**
 * Website states
 * design the page with JQuery
 * the state is defined by url or some click action
 */

    /* state: homepage
    */
function homepage_state(){
      //$('#logo_line').width('90%');
      initmenu(1);
      initmenu(2);
      initmenu(3);
      initmenu(4);
      //$('#menu_top').show();
}

    /* state: design88
    */
function design88_state(){
      $('#logo_line').width('90%');
      //initmenu(1);
      initmenu(2);
      initmenu(3);
      initmenu(4);
      //$('a[href="design88"]').css('color','black');
      $('#menu_top').show();
}


/**
 *  After load actions
 */
$(function() {
   console.log('URL: '+my_url);

   // define what my state by reading my url
   if ( my_url == "/" || my_url == '/index.html')
         homepage_state();

   else if ( my_url == "/design88.html")
         design88_state();

   else if ( my_url == "/whoiswho.html")
         design88_state();

   else homepage_state();

  // hook up clicks with states
    // colorize all links to myself
   var ref = my_url.replace("/", "");
   $('a[href*="'+ref+'"]').css('color','black');

});
