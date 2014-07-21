// YAC Admin 0.2 © 2011 Ricardo Filipo
// Artistic license
// required libs:
// * jquery 1.4.4
// * YAC 0.21
// Don't modify this header

/** Intro

TODO:
 - use YAC js structure
 - YAC deal with login redirects (works only in function deletar)

This script loads the YAC javascript structure and the YAC Admin View.
When the template is totaly loaded from Internet, the user interface
is performed.

The YAC Admin template access this facilities to process and presents
YAC data in the AJAX environment.

This module works under YAC 0.21

. Requirements

The template must have the DOM elements as divs to present data:
 #content
 #panel
 #warn

The login frame in the login page
 #loginFrame

. Basic functionalities
* Show lists of Stacks, Users, Roles and Plugins
* Show stack in a new window
* Show stack in #content div      - TODO
* Create stack in wyswyg editor   - FIX form submit with rte issues
* Edit stack in substacks editor  - TODO
* Edit stack in wyswyg editor     - TODO
* Create user                     - TODO
* Edit user                       - TODO
* Create role                     - TODO
* Edit role                       - TODO
* Create plugin                   - TODO
* Edit plugin                     - TODO

. Dialogs

The dialogs is created at runtime and assumes ids in the form:

 #dialog_<module>_<id>

The editor dialog for stack with id 45 will be:

 #dialog_editor_45


/////////////////////////
Available API

list(module)
deletar()
edit()
newStack()
newUser()

*/

if (yac_version < '0.21') alert ('YAC version ' + yac_version + ' not supported! Please install YAC 0.21 or newer.');


$(function() {
    var admin = Y.C.Admin;

/*
    console.log('Admin Controller structure:');
    console.log(admin);
    console.log('YAC structure:');
    console.log(Y);
    console.log('window structure:');
    console.log(window);
*/

    // page loaded, lets say something to honorable user
    admin.say('YAC Admin version '+yac_version);
    admin.say('Enjoy! It\'s for you!');

    // restore desktop status
    admin.loadList('/admin/list_content');

});

function list(module){
    Y.C.Admin.loadList('/admin/list_'+module);
}

function loadList(module){
    Y.C.Admin.loadList('/admin/list_'+module);
}

////////////////////////////////////////////////////
function deletar(tipo, id){
    if(confirm('Delete '+tipo+' '+id+'? Are you shure?')){
       Y.C.Admin.remove(tipo, id);
    }
    else alert('Not todo!!!');
    return false;
}

////////////////////////////////////////////////////
function toolbarEditor(){
        var html = '<table><tr><td><div id="bt_new" onclick="edit()">Insert New Content</div></td>\
        </tr></table>';
        return html
}

////////////////////////////////////////////////////
function edit(module, id){
        console.log(module);
        console.log(id);
        Y.C.Admin.openEditor(id, module);
/*
        var wid = "editor_dialog_"+id;
        if (document.getElementById(wid)){$(wid).dialog('open'); return false;}
        else {
            var toolbar = toolbarEditor('module','id');
            var $editor = $('<div class="droppable"></div>')
                    .html(toolbar+'<iframe width="770" height="430" src="/edit/'+id+'"></iframe>')
                    .dialog({
                            autoOpen: true,
                            title: 'The '+module+' editor dialog',
                            resizable: false,
                            width: 800,
                            height: 480,
                    });
            $editor.attr('id', wid);
            // $frame.load('/edit/'+id);
            // $editor.dialog('open');
            // prevent the default action, e.g., following a link
            return false;
        }
*/

       return false;
}

////////////////////////////////////////////////////
function newStack(){
        Y.C.Admin.newStack(); // open Y.V.Editor for a new stack
        return false;
}


function newUser(){
        var toolbar = toolbarEditor('module','id');
        var $dialog = $('<div class="droppable"></div>')
                .html(toolbar+'<iframe width="770" height="430" src="/create/user"></iframe>')
                .dialog({
                        autoOpen: true,
                        title: 'The "new User" dialog',
                        resizable: false,
                        width: 800,
                        height: 480
                });
        //$dialog.dialog('open');
        return false;
}

function getStack( url ){
    //console.log (url);
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
            Y.load(xmlhttp.responseText);
        }
    }
    xmlhttp.open("GET",url);
    xmlhttp.send(null);
}

/*
$.getScript('js/YAC/yac_loader.js', function()
{
  //console.log('----- YAC LOADER -----');
  $.getScript('js/YAC/Controller/Root.js', function()
  {
    YAC.Controller.Root = new Root();
    //console.log(yac_state+' - Loaded YAC root controller. ' + YAC.Controller.Root);
  });
  $.getScript('js/YAC/Controller/Edit.js', function()
  {
    YAC.Controller.Edit = new Edit();
    //console.log(yac_state+'Loaded YAC edit controller. ' + YAC.Controller.Edit);
  });
  $.getScript('js/YAC/Controller/Hack.js', function()
  {
    YAC.Controller.Hack = new Hack();
    //console.log(yac_state+'- Loaded YAC hack controller. ' + YAC.Controller.Hack);
  });
  $.getScript('js/YAC/Controller/Admin.js', function()
  {
    YAC.Controller.Admin = new Admin();
    //console.log(yac_state+'- Loaded YAC hack controller. ' + YAC.Controller.Hack);
  });

  $.getScript('js/YAC/Stack.js', function()
  {
    YAC.Model.Stack = new Stack();
    //console.log('Loaded YAC Stack structure.');
    MyWidget.prototype = YAC.Model.Stack;
  });
  console.log('Loading YAC ... ');
});
*/

