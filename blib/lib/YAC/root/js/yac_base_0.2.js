// YAC 0.2  license Affero GPL 
var yac_version = 0.2;

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

// this is a developer flag, 
var yac_mode   = 6;

$.getScript('js/YAC/yac_loader.js', function()
{
  console.log('----- YAC LOADER -----');
  $.getScript('js/YAC/Controller/Root.js', function()
  {
    YAC.Controller.Root = new Root();
    console.log('Loaded YAC root controller. ' + YAC.Controller.Root);
  });

  $.getScript('js/YAC/Stack.js', function()
  {
    YAC.Model.Stack = new Stack();
    console.log('Loaded YAC Stack structure. You can do a MyWidget.prototype = YAC.Model.Stack');
    yac_mode = 0;
  });
  console.log('Loading YAC ... ');
});


