//
// http://www.end6.org/
//


function ieVersion() {
  var rv = -1;
  if (navigator.appName == 'Microsoft Internet Explorer') {
    var ua = navigator.userAgent;
    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if (re.exec(ua) != null)
      rv = parseFloat( RegExp.$1 );
  }
  return rv;
}
var version = ieVersion();

if ((navigator.appName=="Microsoft Internet Explorer") && (version < 7) && readCookie('end6Off') != '1') {
	makeWindow(); 
}


function closeLayer(theobject,makeCook) {
	var makeCook = makeCook;
	document.getElementById(theobject).style.display="none";
	if (makeCook > '0') {
		createCookie('end6Off',1,14400);
	}
}


function createCookie(name,value,minutes) {
	var minutes = minutes;
	if (minutes) {
		var date = new Date();
		date.setTime(date.getTime()+(minutes*60*1000));
		var expires = "; expires="+date.toGMTString();
	} else {
		var expires = "";
	}
	document.cookie = name+"="+value+expires+"; path=/";
}


function readCookie(the_name) {
	var nameEQ = the_name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function makeWindow() {

	bit = '<div id="bigWindow" style="position:absolute;height:1000px;width:100%;background-color:#000000;opacity:0.75;filter:alpha(opacity=75);z-index:990;top:0px;left:0px;"></div>';
	bit += '<div id="iWindow" style="position:relative;width:900px;margin:0px auto;z-index:1000;">';
	bit += '<div style="position:absolute;top:100px;left:250px;width:400px;height:320px;padding:10px;background-color:#ffffff;border:5px solid #cccccc;font-size:14px;">';
	bit += '<div style="text-align:center;"><b>ARG!!!</b><br />Estás utilizando<br /><b>Internet Explorer 6</b>!!!';
	bit += '<br />&nbsp;<br />Esta aplicacion no se visualiza bien en IE6 bastante esfuerzo ha sido que se vea bien en el IE7.';
	bit += '<br />&nbsp;<br />Puedes seguir usándola pero mejora harías actualizándote :).';
	bit += '<br />&nbsp;<br />Este navegador tiene muchos problemas de seguridad.<br />&nbsp;<br />Es muy recomendable  que te cambies a:<br /><a href="http://www.mozilla.com" title="Firefox">Firefox</a>, <a href="http://www.opera.com" title="Opera">Opera</a>, <a href="http://www.apple.com/safari/" title="Safari">Safari</a>, <a href="http://www.flock.com/" title="Flock">Flock</a>, o <a href="http://www.microsoft.com/windows/downloads/ie/getitnow.mspx" title="Internet Explorer 7">Explorer 7</a>.<br />&nbsp;<br />Todos son gratuitos, mucho mejores como navegadores y sólo se tarda un par de minutos en instalarlos.<br />&nbsp;<br />Para saber más, visita <a href="http://www.end6.org/esp/" title="End6!">End 6!</a>.<br />&nbsp;<br />&nbsp;<br /><a href="#" onclick="closeLayer(\'iWindow\',\'1\');closeLayer(\'bigWindow\',\'1\');return false;" style="font-size:10px;">Cierra esta molesta ventana</a></div>'
	bit += '</div>';
	bit += '</div>';
	
	document.write(bit);
	
}