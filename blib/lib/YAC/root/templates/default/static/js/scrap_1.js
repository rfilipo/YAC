console.log('Iniciando YAC');

function load ( html ) {
        var content = document.getElementById("content");
        content.innerHTML = html;
}

function getStack( url ){
    console.log (url);
    url = url+".html";
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
