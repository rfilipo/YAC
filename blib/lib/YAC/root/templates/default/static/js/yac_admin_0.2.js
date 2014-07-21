// YAC 0.2  license Affero GPL
var yac_version = '0.2.1';
console.log('Iniciando YAC Admin');

$(function() {

Y.say('YAC version '+yac_version+' alpha');
Y.say('Enjoy! It\'s for you!');

});

////////////////////////////////////////////////////////

function load ( html ) {
        $('#content').html(html);
}

function list(module){
        $('#panel').load('/admin/list_'+module);
}

function deletar(module, id){
        alert('Delete '+module+' '+id+'?');
       return false;
}

function toolbarEditor(){
        var html = '<table><tr><td>Insert</td>\
        <td>New</td>\
        </tr></table>';
        return html
}

function edit(module, id){
        var toolbar = toolbarEditor('module','id');
        var $dialog = $('<div class="droppable"></div>')
                .html(toolbar+'<iframe width="770" height="430" src="/edit/'+id+'"></iframe>')
                .dialog({
                        autoOpen: false,
                        title: 'The '+module+' editor dialog',
                        resizable: false,
                        width: 800,
                        height: 480
                });
        //$frame.load('/edit/'+id);
        $dialog.dialog('open');
        // prevent the default action, e.g., following a link
        return false;
}

function getStack( url ){
    console.log (url);
    url = "/"+url+"";
    var xmlhttp;
    if (window.XMLHttpRequest) {
    // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
    // code for IE6, IE5
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert(":P Este navegador nao aceita Ajax!");
    }
    xmlhttp.onreadystatechange=function() {
        if(xmlhttp.readyState==4)
        {
            load(xmlhttp.responseText);
    }
}
    xmlhttp.open("GET",url);
    xmlhttp.send(null);
}

if (!console){alert('Por favor, ligue o firebug!!!!');}

console.log('YAC - jquery implementation ' + yac_version);
/**
  * namespace YAC
  *
  */
var YAC        = {};
YAC.Controller = {};
YAC.Model      = {};
YAC.View       = {};
YAC.View.Admin = {};
YAC.View.Root  = {};

var Y = YAC;


YAC.View.Admin.say = function (line){
     var warn = document.getElementById("warn");
     warn.innerHTML += "<li class='warn'>"+line+"</li>" ;
};

Y.say = YAC.View.Admin.say;
///////////////////////////////////////////////////

YAC.View.Root.load = function ( html ) {
        $('#content').html(html);
}

Y.load = YAC.View.Root.load;


///////////////////////////////////////////////////
/**
  * class MyWidget
  *
  */

MyWidget = function ()
{
    this._init ();
}


/**
 * _init sets all MyWidget attributes to their default value. Make sure to call
 * this method within your class constructor
 */
MyWidget.prototype._init = function ()
{
    /**
     * Unique id of widget
     * This attribute will be applied to the div's id.
     */
    this.m_id = "_";
    /**
     *
     */
    this.m_width = 0;
    /**
     *
     */
    this.m_height = 0;
    /**
     *
     */
    this.m_top = 0;
    /**
     *
     */
    this.m_left = 0;
    /**
     * The spected should be a HTML code
     */
    this.m_content = "<p>VAZIO</p>";

    /**Aggregations: */

    /**Compositions: */

}

/**
 *
 * @param id
    *
 */
MyWidget.prototype.setId = function (id)
{
    this.m_id = id;
}


/**
 *
 */
MyWidget.prototype.getId = function ()
{
    return this.m_id;
}

/**
 *
 */
MyWidget.prototype.scale = function (k)
{
  $('#' + this.m_id).width($('#' + this.m_id).width() * k);
  $('#' + this.m_id).height($('#' + this.m_id).height() * k);
  this.m_width = $('#' + this.m_id).width();
  this.m_height = $('#' + this.m_id).height();

  var of = $('#' + this.m_id).offset();
  if (of) {
    this.m_left = of.left * k;
    this.m_top  = of.top * k;
  } else {
    this.m_left = 0;
    this.m_top  = 0;
  }
  $('#' + this.m_id).offset({top: this.m_top, left: this.m_left });
}



/**
  * class MyBody
  *
  */

MyBody = function ()
{
    this._init ();
}

MyBody.prototype = new MyWidget ();

/**
 _init sets all MyBody attributes to their default value. Make sure to call this
 method within your class constructor
 */
MyBody.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
 *
 *
 */
MyBody.prototype.setContent = function (url)
{
    this.m_content = url;
    $('#'+this.m_id).load(url);
    console.log (url + ' -> ' + this.m_id);
    console.log ($('#'+this.m_id));
}



/**
  * class MyFooter
  *
  */

MyFooter = function ()
{
    this._init ();
}

MyFooter.prototype = new MyWidget ();

/**
 * _init sets all MyFooter attributes to their default value. Make sure to call
 * this method within your class constructor
 */
MyFooter.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
  * class MyHead
  *
  */

MyHead = function ()
{
    this._init ();
}

MyHead.prototype = new MyWidget ();

/**
_init sets all MyHead attributes to their default value. Make sure to call this
method within your class constructor
 */
MyHead.prototype._init = function ()
{
  this.m_id = 'header';
  this.m_width = $('#header').width();
  this.m_height = $('#header').height();
  var offset = $('#header').offset();
  this.m_top = offset.top;
  this.m_left = offset.left;

    /**Aggregations: */

    /**Compositions: */

}

/**
 *
 */
MyHead.prototype.scale = function (k)
{
  $('#header').width($('#header').width() * k);
  $('#header').height($('#header').height() * k);
  $('#header_img').width($('#header').width());
  $('#header_img').height($('#header').height());
  this.m_width = $('#header').width();
  this.m_height = $('#header').height();

  $('#borderBody').width($('#borderBody').width() * k );
  $('#borderBody').height($('#borderBody').height() * k );
  var ofbb = $('#borderBody').offset();
  ofbb.left = ofbb.left * k;
  ofbb.top = ofbb.top * k;
  $('#borderBody').offset(ofbb);
}



/**
  * class MyLeftPane
  *
  */

MyLeftPane = function ()
{
    this._init ();
}

MyLeftPane.prototype = new MyWidget ();

/**
 * _init sets all MyLeftPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
MyLeftPane.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
 *
 */
MyLeftPane.prototype.scale = function (k)
{
  $('#'+this.m_id).width($('#'+this.m_id).width() * k);
  $('#'+this.m_id).height($('#'+this.m_id).height() * k);
  $('#'+this.m_id+'_img').width($('#'+this.m_id).width());
  $('#'+this.m_id+'_img').height($('#'+this.m_id).height());
  this.m_width = $('#'+this.m_id).width();
  this.m_height = $('#'+this.m_id).height();

  var ofbb = $('#'+this.m_id).offset();
  this.m_left = ofbb.left * k;
  this.m_top = ofbb.top * k;
  $('#'+this.m_id).offset({top: this.m_top , left: this.m_left});
}

/**
  * class MyRightPane
  *
  */

MyRightPane = function ()
{
    this._init ();
}

MyRightPane.prototype = new MyWidget ();

/**
 * _init sets all MyRigthPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
MyRightPane.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
  * class MyMenu
  *
  */

MyMenu = function ()
{
    this._init ();
}

MyMenu.prototype = new MyWidget ();

/**
 * _init sets all MyRigthPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
MyMenu.prototype._init = function ()
{

    this.m_itens = 7;

    /**Aggregations: */

    /**Compositions: */

}

/**
 *
 */
MyMenu.prototype.scale = function (k)
{
  // font-size
  var str = $('.menu').css('font-size');
  var fs = str.replace(/px/gi,'');
  fs *= k;
  $('.menu').css('font-size', fs + "px");

  // div sizes
  $('.menu').width(     $('.menu').width() * k);
  $('.menu').height(    $('.menu').height() * k);
  $('.menu_img').width( $('.menu').width());
  $('.menu_img').height($('.menu').height());
  //this.m_width[i] = $('#menu_'+i).width();
  //this.m_height[i] = $('#menu_'+i).height();

  // menus offset
  // must have 7 menu itens
  menu = [];
  var i = 0;
  var id;
  while (i < this.m_itens ){
    id = '#menu_'+i;
    menu[i] = {};
    menu[i].pos = $(id).offset();
    menu[i].pos.left = menu[i].pos.left * k;
    menu[i].pos.top = menu[i].pos.top * k;
    $(id).offset(menu[i].pos);
    i++;
  }
}



$.getScript('js/YAC/yac_loader.js', function()
{
  console.log('----- YAC LOADER -----');
  $.getScript('js/YAC/Controller/Root.js', function()
  {
    YAC.Controller.Root = new Root();
    console.log(yac_state+' - Loaded YAC root controller. ' + YAC.Controller.Root);
  });
  $.getScript('js/YAC/Controller/Edit.js', function()
  {
    YAC.Controller.Edit = new Edit();
    console.log(yac_state+'Loaded YAC edit controller. ' + YAC.Controller.Edit);
  });
  $.getScript('js/YAC/Controller/Hack.js', function()
  {
    YAC.Controller.Hack = new Hack();
    console.log(yac_state+'- Loaded YAC hack controller. ' + YAC.Controller.Hack);
  });
  $.getScript('js/YAC/Stack.js', function()
  {
    YAC.Model.Stack = new Stack();
    console.log('Loaded YAC Stack structure.');
    MyWidget.prototype = YAC.Model.Stack;
  });
  console.log('Loading YAC ... ');
});


