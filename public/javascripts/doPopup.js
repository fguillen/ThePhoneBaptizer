function doPopup() {
	  
	  if (!document.getElementsByTagName) return false; 
	  
	  var links = document.getElementsByTagName("a");
	  for (var i=0; i < links.length; i++) {
			if (links[i].className.match("popup")) {
				
				var SectionID = links[i].getAttribute("href").split("#")[1];
				var helpTextDiv = document.getElementById(SectionID);
				helpTextDiv.style.display = 'none';		
				
				links[i].onclick = function() {
					
					var popups = document.getElementsByTagName("a");
					for (var i=0; i < popups.length; i++) {
						if (popups[i].className.match("popup")) {
						
							var ThisPopupID = popups[i].getAttribute("href").split("#")[1];
							var SelectedPopupID = this.getAttribute("href").split("#")[1];
								
							if(ThisPopupID == SelectedPopupID){							
							}else{					
								UnselectedPopupDiv = document.getElementById(ThisPopupID);
								UnselectedPopupDiv.style.display = 'none';	
							}
						}
					}
						
					var SectionID = this.getAttribute("href").split("#")[1];
					var helpTextDiv = document.getElementById(SectionID);
					
					if(helpTextDiv.style.display == "block"){
						helpTextDiv.style.display = 'none';
					}else{
						/* display popup */
						helpTextDiv.style.zIndex = '10';
						helpTextDiv.style.display = 'block';
						helpTextDiv.style.position = 'absolute';
						helpTextDiv.style.left = '10%';
						helpTextDiv.focus();
					}
					
					helpTextDiv.onclick = function(){
						/* Hide popups */
						helpTextDiv.style.zIndex = '110';
						helpTextDiv.style.display = 'none';
						return false;
					}
					return false;
				}		  
			}
	  }
}


function closePopups(){
		var popups = document.getElementsByTagName("a");
		for (var i=0; i < popups.length; i++) {
			if (popups[i].className.match("popup")) {
			
				var ThisPopupID = popups[i].getAttribute("href").split("#")[1];	
				ThisPopup = document.getElementById(ThisPopupID);						
				if(ThisPopup.style.display == "block"){
						ThisPopup.style.display = 'none';
				}
			}
		}
}




function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    }
  }
}


addLoadEvent(doPopup);

