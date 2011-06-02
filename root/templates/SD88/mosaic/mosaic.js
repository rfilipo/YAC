/**
 * Mosaic 0.2
 * GPL Affero
 * author: Monsenhor <monsenhor at cpan.org>
 * 2008 - 2011
 */

// Define a version
var mosaic_version = "0.2";
// Define and verify requirements
if (!window.parent.YAC){
   alert("YAC not found! Mosaic requires YAC... Bad!");
} 
var needed_YAC = "0.21"; 
if ( ! window.parent.yac_version || window.parent.yac_version < needed_YAC ) {
   alert("YAC Version too slow! "+window.parent.yac_version+". I need version "+needed_YAC+". I think it won't work ...")
}

// Extension startup
// Description: Mosaic starts on jquery load
$(function(){

    // Use debug and tests
    console.log("MOsAic "+mosaic_version);

    var m_w = $(window).width();
    var m_h = $(window).height();
    var k = m_w/8
    var serie = 'logos';   //FIXME!!!!!
    $('.m_0').width(k);    
    $('.m_0').height(k);
    console.log(m_w+' : '+m_h);
    /*
    $.getJSON('/mosaic/json/'+serie, function(image) {
        mosaic_images = image;
    });
    */
    $(parent.window).bind('sizeChange', function() {
/*
        var k = $(window).width() / m_w;
        //console.log('medidas!!! '+k);
        $('.m_0').width(141 * k);
        $('.m_0').height(141 * k);
*/
        parent.window.location.reload(true);
    });
    // change link behavior
    $('a').click(function(){
        return false;
    });

});


// Inject Mosaic structure in YAC namespace
// if Extension is in a iframe YAC is in window.parent.YAC
Y=window.parent.YAC;
Y.C.Mosaic = {};
Y.M.Mosaic = {};
Y.V.Mosaic = {};

// Mosaic strutucture
var mosaic_images = Y.M.Mosaic;

// TODO complete closures
// TODO put some functions, like overflow, centerImage, etc in YAC core

//console.log('YAC structure:');
//console.log(Y);


// Inject JQuery Extensions
// event sizeChange
(function(){
    var interval;

    jQuery.event.special.sizeChange = {
        setup: function(){
            var self = this;
            $this = $(this);
            var w = $this.width();
            var h = $this.height();
            interval = setInterval(function(){
                if(w != $this.width() || h != $this.height()) {
                    w = $this.width();
                    h = $this.height();
                    //console.log('Ai!!!!!');
                    jQuery.event.handle.call(self, {type:'sizeChange'});
                }
            },100);
        },
        teardown: function(){
            clearInterval(interval);
        }
    };
})();

function showArrows(theImages,myI){
   var prevI=myI-1;
   var nextI=myI+1;
   $("#arrow_left").show();
   $("#arrow_right").show();
   if(!theImages[prevI]){$("#arrow_left").hide()}
   if(!theImages[nextI]){$("#arrow_right").hide()}
}

function showMosaic(img, $overflow){
/**
   eval('image.src = mosaic_images.m__'+obj.name+';');
   //console.log(image.src);
   if (!image.src){return;};
   image.frame = $('#mosaic_dialog');
   image.arrowLeft = "<div style='cursor:pointer;z-index:3000;position:absolute;top:50%;left:12px'><img id='arrow_left' width='50' height='39' src='images/arrow_white_left.png' ></div>"; 
   image.arrowRight = "<div style='cursor:pointer;z-index:3000;position:absolute;top:50%;right:12px'><img id='arrow_right' width='50' height='39' src='images/arrow_white_right.png'></div>"; 
   image.code = "<img id='image' width='100%' height='100%' src='"+image.src+"'>";
   image.bclose = '<div onclick="$(\'#mosaic_dialog\').hide()" style="position:absolute;top:12px;right:12px"><a href="#" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-state-default ui-icon-closethick">close</span></a></div>';
   image.frame.html("<div>"+image.code+image.bclose+image.arrowLeft+image.arrowRight+"</div>");
   image.frame.css('visibility','visible');
   
   var myI = 0;
   var nextI = 0;
   var prevI = 0;
   var i = 0;
   var theImages = [];
   $.each(mosaic_images, function(key,val){
       theImages[i] = val;
       if (String(key).indexOf(obj.name) != -1){
          myI=i;
       }
       i++;
   });
   showArrows(theImages,myI);
   $("#arrow_left").hover(
       function(){
           this.src="images/arrow_red_left.png"
       },
       function(){
           this.src="images/arrow_white_left.png"
   });
   $("#arrow_right").hover(
       function(){
           this.src="images/arrow_red_right.png"
       },
       function(){
           this.src="images/arrow_white_right.png"
   });
   
   $("#arrow_left").click(function(){
         $('#image').attr('src',theImages[myI-1]);
         myI--; 
         showArrows(theImages, myI);
   }); 
    $("#arrow_right").click(function(){
        $('#image').attr('src',theImages[myI+1]);
         myI++;
         showArrows(theImages, myI);
   }); 
   image.frame.show();
*/
}

function mosaicAction(img)
{
  var image = {};

  image.$img = $(img);

   // div over all. mosaic is in iframe, so window.parent
  image.$overflow = window.parent.$('<div id="#overflow" style="position:absolute;top:0;left:0;z-index:500;width:100%;height:100%;background-color:black;opacity:0.3">VAZIO</div>').appendTo('body');
  // show overflow
  // image.$overflow.fadeIn('slow');
  // hide overflow
  image.$overflow.hide();
  // The image
  image.$frame=window.parent.$('<img src="/images/yeast_infection_in_men.JPG" style="display:none;z-index:1000; position:absolute;">').appendTo('body');
  image.$frame.attr('src', '/mosaic/show/logos/'+image.$img.attr('alt'));

  // image to size of mosaic frame
  // because mosaic frame format is relative to page we need to pick 
  // image original relations format in pixels to resize
  var rel = image.$img.attr('refy')/image.$img.attr('refx');
  var newWidth  = window.parent.$('#mosaic').width() + 4;
  var newHeight = newWidth * rel;
  image.$frame.height(newHeight);
  image.$frame.width(newWidth);
  image.$frame.css("height", newHeight+'px');
  image.$frame.css("width", newWidth+'px');
  console.log(rel);
  //console.log(image.$frame.width());

  // uncomment to show image in real size
  //image.$frame.attr('height', image.$img.attr('refy'));
  //image.$frame.attr('width', image.$img.attr('refx'));


  // center image
/*
  var h_center = image.$overflow.width()/2;
  var v_center = image.$overflow.height()/2;
  var h_image  = image.$frame.width();
  var v_image  = image.$frame.height();
  image.$frame.css("left",h_center-(h_image/2)+"px");
  image.$frame.css("top",v_center-v_image/2+"px");
*/
  // we want to put image over mosaic for SD88 tt, 
  // offset in pixels. The header have 15% for logo and 3px for line
  var yoffset = (image.$overflow.height() * 0.18) - 2 ;
  var xoffset = image.$overflow.width() * 0.26 - 2 ;
  image.$frame.css("left", xoffset + "px");
  image.$frame.css("top", yoffset + "px");


  // show image
  //image.$frame.slideDown(2000);
  image.$frame.fadeIn(2000);
}
