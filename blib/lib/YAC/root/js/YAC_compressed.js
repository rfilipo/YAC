if(!console){alert('Por favor,ligue o firebug!!!!');}console.log('YAC 0.21 debug version');var yac_version='0.21';console.log('YAC-jquery implementation '+yac_version);var YAC={};YAC.Controller={};YAC.Model={};YAC.View={};YAC.View.Admin={};YAC.View.Root={};var Y=YAC;var $Y=YAC;var yac=YAC;var ycms=YAC;var cms=YAC;YAC.View.Admin.say=function(line){     var warn=document.getElementById("warn");     warn.innerHTML+="<li class='warn'>"+line+"</li>" ;};Y.say=YAC.View.Admin.say;YAC.View.Root.load=function(html){        $('#content').html(html);}Y.load=YAC.View.Root.load;YAC.View.Admin.loadList=function(url){        $('#panel').load(url);}Y.loadList=YAC.View.Admin.loadList;YAC.View.Admin.closeEditor=function(id){        $('#editor_dialog_'+id).dialog("close");}Y.closeEditor=YAC.View.Admin.closeEditor;MyWidget=function();{    this._init();}MyWidget.prototype._init=function();{    this.m_id="_";    this.m_width=0;    this.m_height=0;    this.m_top=0;    this.m_left=0;    this.m_content="<p>VAZIO</p>";}MyWidget.prototype.setId=function(id);{    this.m_id=id;}MyWidget.prototype.getId=function();{    return this.m_id;}MyWidget.prototype.scale=function(k);{  $('#'+this.m_id).width($('#'+this.m_id).width()*k);  $('#'+this.m_id).height($('#'+this.m_id).height()*k);  this.m_width=$('#'+this.m_id).width();  this.m_height=$('#'+this.m_id).height();  var of=$('#'+this.m_id).offset();  if(of){    this.m_left=of.left*k;    this.m_top=of.top*k;}else{    this.m_left=0;    this.m_top=0;}  $('#'+this.m_id).offset({top:this.m_top,left:this.m_left});}MyBody=function();{    this._init();}MyBody.prototype=new MyWidget();MyBody.prototype._init=function();{}MyBody.prototype.setContent=function(url);{    this.m_content=url;    $('#'+this.m_id).load(url);    console.log(url+'->'+this.m_id);    console.log($('#'+this.m_id));}MyFooter=function();{    this._init();}MyFooter.prototype=new MyWidget();MyFooter.prototype._init=function();{}MyHead=function();{    this._init();}MyHead.prototype=new MyWidget();MyHead.prototype._init=function();{  this.m_id='header';  this.m_width=$('#header').width();  this.m_height=$('#header').height();  var offset=$('#header').offset();  this.m_top=offset.top;  this.m_left=offset.left;}MyHead.prototype.scale=function(k);{  $('#header').width($('#header').width()*k);  $('#header').height($('#header').height()*k);  $('#header_img').width($('#header').width());  $('#header_img').height($('#header').height());  this.m_width=$('#header').width();  this.m_height=$('#header').height();  $('#borderBody').width($('#borderBody').width()*k);  $('#borderBody').height($('#borderBody').height()*k);  var ofbb=$('#borderBody').offset();  ofbb.left=ofbb.left*k;  ofbb.top=ofbb.top*k;  $('#borderBody').offset(ofbb);}MyLeftPane=function();{    this._init();}MyLeftPane.prototype=new MyWidget();MyLeftPane.prototype._init=function();{ }MyLeftPane.prototype.scale=function(k);{  $('#'+this.m_id).width($('#'+this.m_id).width()*k);  $('#'+this.m_id).height($('#'+this.m_id).height()*k);  $('#'+this.m_id+'_img').width($('#'+this.m_id).width());  $('#'+this.m_id+'_img').height($('#'+this.m_id).height());  this.m_width=$('#'+this.m_id).width();  this.m_height=$('#'+this.m_id).height();  var ofbb=$('#'+this.m_id).offset();  this.m_left=ofbb.left*k;  this.m_top=ofbb.top*k;  $('#'+this.m_id).offset({top:this.m_top,left:this.m_left});} MyRightPane=function();{    this._init();}MyRightPane.prototype=new MyWidget();MyRightPane.prototype._init=function();{}MyMenu=function();{    this._init();}MyMenu.prototype=new MyWidget();MyMenu.prototype._init=function();{    this.m_itens=7;}MyMenu.prototype.scale=function(k);{  var str=$('.menu').css('font-size');  var fs=str.replace(/px/gi,'');  fs*=k;  $('.menu').css('font-size',fs+"px");  $('.menu').width($('.menu').width()*k);  $('.menu').height($('.menu').height()*k);  $('.menu_img').width($('.menu').width());  $('.menu_img').height($('.menu').height());  menu=[];  var i=0;  var id;  while(i<this.m_itens){    id='#menu_'+i;    menu[i]={};    menu[i].pos=$(id).offset();    menu[i].pos.left=menu[i].pos.left*k;    menu[i].pos.top=menu[i].pos.top*k;    $(id).offset(menu[i].pos);    i++;}}