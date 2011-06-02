if (!console){alert('Por favor, ligue o firebug!!!!');}


/** YAC 0.2  license Affero GPL 
 * required libs:
 * jquery 1.4.4
 */
$(function() {
    console.log($.fn.jquery);
});
var yac_version = '0.21';
console.log('YAC - jquery implementation ' + yac_version);
/**
  * namespace YAC
        YAC uses static objects to create namespaces in js 
  *
  * YAC.js organizes the YAC infrastructure, deals with urls, Ajax and 
  * implements the YAC classes.
  */

 /**
  * YAC Ajax infrastructure.

  * As a MVC presents classes, static objects and functions under 
  * that default namespace: Y.M, Y.V and Y.C ressembling to YAC's
  * Model, View an Controller.
  * Controller implements the UI actions.
  * Views are YACWidgets or simple JQuery elements 
  * Models are based in Catalyst urls.
  */ 
  
var YAC        = {};

YAC.Controller = {};
YAC.Model      = {};
YAC.View       = {};

YAC.Controller.Admin = {};
YAC.View.Admin       = {};

YAC.Controller.Root  = {};
YAC.View.Root        = {};

/**
* Some YAC alias
*/
var $Y    = YAC;
var $y    = YAC;
var Y     = YAC;
var y     = YAC;
var yac   = YAC;
var ycms  = YAC;
var cms   = YAC;
var yaccms= YAC;
Y.C = YAC.Controller;
Y.M = YAC.Model;
Y.V = YAC.View;

/** 
 * Static Views
 */

/** 
 * Content element
 * The html document must have a div with id='content' 
 */
Y.V.Root.content = function (){
     return $('#content');
}


/** 
 * Warn element
 * The html document must have a div with id='warn' 
 */
Y.V.Admin.warn = function (){
    return document.getElementById("warn");
}

/**
 * Panel element
 * The html document must have a div with id='panel' 
 */
Y.V.Admin.panel = function (){
    return $('#panel');
}

/**
 * Editors element
 * returns the JQuery element.
 * The editors elements are created on demand by YAC.
 * In this version YAC have 4 types of editor modules
 *    - 'content': wysywyg editor bsased in rte
 *    - 'stack'  : inline editor, organizer
 *    - 'user    :TODO'
 *    - 'role'   :TODO
 *    - 'plugin' :TODO
 *
 * To explicit create a new Editor say
 *    var smartEditor = new Y.V.Editor();
 */
Y.V.Admin.editor = function (id, module){
    return $('#editor_'+module+'_'+id);
}

/** Editor instance at focus now */
Y.V.focusEditor = {};  // empty

/**
 * Static Controls
 */

Y.C.Admin.say = function (line){
     Y.V.Admin.warn().innerHTML += "<li class='warn'>"+line+"</li>" ;
};
// Alias
Y.say = YAC.Controller.Admin.say;

/**
 * Y.C.Root.load
 * loads the html content in Root View
 */
Y.C.Root.load = function ( html ) {
        Y.V.Root.content.html(html);
}

Y.load = Y.C.Root.load;


YAC.Controller.Admin.loadList = function ( url ) {
        Y.V.Admin.panel().load(url);
}

Y.loadList = YAC.Controller.Admin.loadList;


Y.C.Admin.closeEditor = function ( id, module ) {
        Y.V.Admin.editor(id, module).dialog("close");
}

Y.closeEditor = Y.C.Admin.closeEditor;

Y.C.Admin.openEditor = function (id, module ) {
        Y.V.focusEditor = new Y.V.Editor(id,module); 
        return Y.V.focusEditor;
}
/*
 * deleta um stack
 * TODO implementar delete para users, roles, plugins
 */
Y.C.Admin.remove = function (tipo, id) {
       $('#panel').load('/edit/delete/'+id,
       function(response, status, xhr) {
          if (status == "error") {
            var msg = "Sorry but there was an error: ";
            $("#panel").html(msg + xhr.status + " " + xhr.statusText);
          }
          Y.say(status);
          //alert('Deletei ... :) ');
          if ($('#loginFrame').length){
            var msg = "Timeout! Redirecting to login ...";
            $("#panel").html(msg);
            alert ('Timeout! Redirecting to login ...');
            top.location.href="/login";
          } 
        });
}

Y.C.Admin.newStack = function ( ) {
        Y.V.focusEditor = new Y.V.Editor(0,'stack'); 
        // 0 is a new stack id in YAC
        return Y.V.focusEditor;
}


/**
  * YAC js classes.
  * 
  */

/**
  * class Y.V.Widget
  * Abstract class
  * Can scale with page, have x, y, h and w 
  */

Y.V.Widget = function ()
{
    this._init ();
}


/**
 * _init sets all Y.V.Widget attributes to their default value. Make sure to call
 * this method within your class constructor
 */
Y.V.Widget.prototype._init = function ()
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
Y.V.Widget.prototype.setId = function (id)
{
    this.m_id = id;
}


/**
 * 
 */
Y.V.Widget.prototype.getId = function ()
{
    return this.m_id;
}

/**
 * 
 */
Y.V.Widget.prototype.scale = function (k)
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
  * class Y.V.Editor
  * Can scale with page, have x, y, h and w
  * Have a toolbar
  * Deal with url and model

TODO: separate view
 
  */

Y.V.Editor = function (id, module)
{
  this._init (id, module);
  this.url(id, module);
  // identify interface
  if (module == 'stack' && id == 0 ) { //its a new stack issue
    module = 'content';
    this.toolbar = {} ; //toolbarEditor('module','id');
    this.$editor = $('<div></div>')
                .html('<iframe width="758" height="380" src="/edit/editor/0"></iframe>')
                .dialog({
                        autoOpen: true,
                        title: 'The new Content editor dialog',
                        resizable: true,
                        width: 800,
                        height: 480
                });
    this.$editor.attr('id', "editor_"+module+"_"+id);
    //console.log('Editor structue');
    //console.log(this);
  } else if (module == 'content' ) { //edit a stack content
    this.toolbar = {} ; //toolbarEditor('module','id');
    this.$editor = $('<div></div>')
                .html('<iframe width="758" height="380" src="/edit/editor/'+id+'"></iframe>')
                .dialog({
                        autoOpen: true,
                        title: 'The Content editor dialog for stack: '+id,
                        resizable: true,
                        width: 800,
                        height: 480
                });
    this.$editor.attr('id', "editor_"+module+"_"+id);
  } else{
    // TODO: 
    var module = 'stack';
    var tbhtml = '<table><tr><td><div id="bt_new" onclick="edit()">Insert New Content</div></td></tr></table>';

    var toolbar = {} ; //toolbarEditor('module','id');
    var $editor = $('<div class="droppable"></div>')
            .html(tbhtml+'<iframe width="770" height="430" src="/edit/'+id+'"></iframe>')
            .dialog({
                    autoOpen: true,
                    title: 'The '+module+' editor dialog',
                    resizable: false,
                    width: 800,
                    height: 480,
            });
    $editor.attr('id', wid);
  }
 
}

Y.V.Editor.prototype.url = function (id, module)
{
    this.m_url = '/edit/'+module+'/'+id;
    return this.m_url; 
}

Y.V.Editor.prototype._init = function (id, module)
{
   /**
     * Unique id of Editor
     * This attribute will be applied to the div's id.
     */
    this.m_id = id;
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
    this.m_content = $("<p>VAZIO</p>");
    
    this.m_module = module;
    
    /**Aggregations: */

    /**Compositions: */

}









/**
  * class Y.V.Body
  * 
  */

Y.V.Body = function ()
{
    this._init ();
}

Y.V.Body.prototype = new Y.V.Widget ();

/**
 _init sets all Y.V.Body attributes to their default value. Make sure to call this
 method within your class constructor
 */
Y.V.Body.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}


/**
 * 
 * 
 */
Y.V.Body.prototype.setContent = function (url)
{
    this.m_content = url;
    $('#'+this.m_id).load(url);
    //console.log (url + ' -> ' + this.m_id);
    //console.log ($('#'+this.m_id));
}



/**
  * class Y.V.Footer
  * 
  */

Y.V.Footer = function ()
{
    this._init ();
}

Y.V.Footer.prototype = new Y.V.Widget ();

/**
 * _init sets all Y.V.Footer attributes to their default value. Make sure to call
 * this method within your class constructor
 */
Y.V.Footer.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
  * class Y.V.Header
  * 
  */

Y.V.Header = function ()
{
    this._init ();
}

Y.V.Header.prototype = new Y.V.Widget ();

/**
_init sets all Y.V.Header attributes to their default value. Make sure to call this
method within your class constructor
 */
Y.V.Header.prototype._init = function ()
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
Y.V.Header.prototype.scale = function (k)
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
  * class Y.V.LeftPane
  * 
  */

Y.V.LeftPane = function ()
{
    this._init ();
}

Y.V.LeftPane.prototype = new Y.V.Widget ();

/**
 * _init sets all Y.V.LeftPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
Y.V.LeftPane.prototype._init = function ()
{
 
    /**Aggregations: */

    /**Compositions: */

}

/**
 * 
 */
Y.V.LeftPane.prototype.scale = function (k)
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
  * class Y.V.RightPane
  * 
  */

Y.V.RightPane = function ()
{
    this._init ();
}

Y.V.RightPane.prototype = new Y.V.Widget ();

/**
 * _init sets all Y.V.RightPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
Y.V.RightPane.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
  * class Y.V.Menu
  * 
  */

Y.V.Menu = function ()
{
    this._init ();
}

Y.V.Menu.prototype = new Y.V.Widget ();

/**
 * _init sets all Y.V.RightPane attributes to their default value. Make sure to call
 * this method within your class constructor
 */
Y.V.Menu.prototype._init = function ()
{

    this.m_itens = 7;

    /**Aggregations: */

    /**Compositions: */

}

/**
 * 
 */
Y.V.Menu.prototype.scale = function (k)
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

/**
 * YAC Models
 */


/**
 * Static Model functions
 */

Y.M.url = function (id, module) {

}

/**
  * class Y.M.Stack
  * Abstract class. See implementation Y.M.Catalyst
  */

Y.M.Stack = function ()
{
    this._init ();
}


/**
 * _init sets all Y.M.Stack attributes to their default value. Make sure to call this
 * method within your class constructor
 */
Y.M.Stack.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
 * 
 */
Y.M.Stack.prototype.url = function ()
{
    
}


/**
 * 
 */
Y.M.Stack.prototype.content = function ()
{
    
}


/**
 * 
 */
Y.M.Stack.prototype.stacks = function ()
{
    
}













/**
  * class Y.M.Catalyst
  * 
  */

Y.M.Catalyst = function ()
{
    this._init ();
}


Y.M.Catalyst.prototype = new Y.M.Stack ();
/**
 * _init sets all Y.M.Catalyst attributes to their default value. Make sure to call this
 * method within your class constructor
 */
Y.M.Catalyst.prototype._init = function ()
{

    /**Aggregations: */

    /**Compositions: */

}

/**
 * 
 */
Y.M.Catalyst.prototype.url = function ()
{
    
}


/**
 * 
 */
Y.M.Catalyst.prototype.content = function ()
{
    
}


/**
 * 
 */
Y.M.Catalyst.prototype.stacks = function ()
{
    
}







/**
  * class Y.M.Admin
  * 
  */

Y.M.Admin = function (module)
{
    this._init (module);
}


Y.M.Admin.prototype = new Y.M.Stack ();


/**
 * _init sets all Y.M.Admin attributes to their default value. Make sure to call this
 * method within your class constructor
 */
Y.M.Admin.prototype._init = function (module)
{

    this.m_url = "/admin/list_"+module;
    /**Aggregations: */

    /**Compositions: */

}

/**
 * 
 */
Y.M.Admin.prototype.url = function ( id, module)
{
    this.m_url = "/admin/list_"+module;
    return this.m_url; 
}


/**
 * 
 */
Y.M.Admin.prototype.content = function ()
{
    
}


/** 
 * Static Model Objects
 */


//Y.M.$admin = new Y.M.Admin ();
//Y.M.$root  = new Y.M.Stack ();
