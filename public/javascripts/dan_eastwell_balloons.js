//
// JavaScript de:
//  http://www.thoughtballoon.co.uk/blog/articles/2006/11/25/creating-a-css-html-javascript-comments-balloon-popup
//
// Bastante hackeado por: fernandoguillen.info
//

//alert( "popup" );

function iniciarBalloons() {
	  
	  if (!document.getElementsByTagName) return false; 
	  
	  var links = document.getElementsByTagName("a");
	  for (var i=0; i < links.length; i++) {
			if (links[i].className.match("popup")) {
				
				var SectionID = links[i].getAttribute("href").split("#")[1];
				var helpTextDiv = document.getElementById(SectionID);
				helpTextDiv.style.display = 'none';		
				
				//
				// en principio en el click llamamos al onclick Activo
				//
				links[i].onclick = 
					function(event) {
						onClickActivo( event, this );
						return false;
					}
				
				links[i].onmouseover = function(event){
					elOver( event, this );
					return false;
				}
				
			}
	  }
}

//
// Cuando se pulsa en un link se le desactiva el onmouseout
// tambien se desactivan todos los onmouseover de los otros links
//
function onClickActivo( event, objeto ){
	//alert( "primer click" );
	
	//
	// color activado
	//
	objeto.style.backgroundColor = '#618b11';
	
	
	//
	// desactivamos su onmouseout 
	//
	objeto.onmouseout = function(event){
	 	return false;
	}
	
	//
	// desactivamos el onmouseover y el onmouseclick de todos los links
	//
  var links = document.getElementsByTagName("a");
  for (var i = 0; i < links.length; i++) {
		if( links[i].className.match("popup") ) {
			links[i].onmouseover = 
				function(event){
					return false;
				}
				
			links[i].onclick = 
				function(event){
					return false;
				}
		}
	}
	
	//
	// ahora cuando volvamos a pulsar desactivaremos el efecto
	//
	objeto.onclick = 
		function(event) {
			onClickDesactivo( event, this );
			return false;
		}
	
	return false;
}

//
// La segunda vez que se pulsa sobre un link se vuelve a 
// dejar todo como estaba
//
function onClickDesactivo( event, objeto ){
	//alert( "segundo click" );
	
	//
	// color desactivado
	//
	objeto.style.backgroundColor = 'black';
	
	//
	// desaparece el balloon
	//
	var SectionID = objeto.getAttribute("href").split("#")[1];
	var helpTextDiv = document.getElementById(SectionID);
	helpTextDiv.style.zIndex = '110';
	helpTextDiv.style.display = 'none';
	
	//
	// volvemos a activar el onmouseout
	//
	objeto.onmouseout = 
		function(){
			/* Hide popups */
			helpTextDiv.style.zIndex = '110';
			helpTextDiv.style.display = 'none';
			return false;
		}
	
	//
	// reactivamos el onmouseover y el onclick the todos los links
	//
  var links = document.getElementsByTagName("a");
  for (var i = 0; i < links.length; i++) {
		if (links[i].className.match("popup")) {
			links[i].onmouseover = 
				function(event){
					elOver( event, this );
					return false;
				}
				
			links[i].onclick = 
				function(event) {
					onClickActivo( event, this );
					return false;
				}
		}
	}
	
	
	return false;
}



//
// funcion que se ejecuta cuando el raton está sobre un link
// esta función hay que desactivarla en todos los links cuando se pulsa
// en uno
// y volverla ha activar cuando se vuelve a pulsar.
//
function elOver( event, objeto ){
//	alert( objeto );
	var popups = document.getElementsByTagName("a");
	for (var i=0; i < popups.length; i++) {
		if (popups[i].className.match("popup")) {
		
			var ThisPopupID = popups[i].getAttribute("href").split("#")[1];
			var SelectedPopupID = objeto.getAttribute("href").split("#")[1];
				
			if(ThisPopupID == SelectedPopupID){							
			}else{					
				UnselectedPopupDiv = document.getElementById(ThisPopupID);
				UnselectedPopupDiv.style.display = 'none';	
			}
		}
	}
		
	
	var SectionID = objeto.getAttribute("href").split("#")[1];
	var helpTextDiv = document.getElementById(SectionID);
	
	if(helpTextDiv.style.display == "block"){
		helpTextDiv.style.display = 'none';
	}else{
		/* display popup */
		helpTextDiv.style.zIndex = '10';
		helpTextDiv.style.display = 'block';
		helpTextDiv.style.position = 'absolute';
//		helpTextDiv.focus();
		
	//	helpTextDiv.style.left = (event.pageX - dictionary_box_X) + 'px';
	//	helpTextDiv.style.top = (event.pageY - 70) + 'px';

//		alert( "screenX: " + event.screenX );
//		alert( "pageX: " + event.pageX );
//		alert( "offsetX: " + event.offsetX );
//		alert( "x: " + event.x );

//		YAHOO.util.Dom.setX( helpTextDiv, event.clientX - 40 );
//		YAHOO.util.Dom.setY( helpTextDiv, event.clientY + 10 );						
		
//		alert( "left: " + document.documentElement.scrollLeft );

		var tempX = 0;
		var tempY = 0;
	
		if (!event) { //para IE
			event = window.event;
			tempX = event.clientX + document.documentElement.scrollLeft - 30;
			tempY = event.clientY + document.documentElement.scrollTop + 10;
		} else { 
			tempX = event.pageX - 40;
			tempY = event.pageY + 10;
		}

		YAHOO.util.Dom.setX( helpTextDiv, tempX );
		YAHOO.util.Dom.setY( helpTextDiv, tempY );
		
		
	}
	
	
	
	objeto.onmouseout  = function(){
		helpTextDiv.style.zIndex = '110';
		helpTextDiv.style.display = 'none';
		return false;
	}
	
	
	return false;
}



// call to inciarBalloons on name.list
