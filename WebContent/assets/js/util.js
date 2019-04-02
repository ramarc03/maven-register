

/*
 * Retrieves the x coordinate of the specified widget
 */
function getX(obj){
	if (obj.offsetParent){
		var x = 0;
		while (obj.offsetParent){
			x += obj.offsetLeft
			obj = obj.offsetParent;
		}
		return x;
	} else {
		return obj.x;
	}
}

/* 
 * Retrieves the y coordinate of the specified widget
 */
function getY(obj){
	var y = 0;
	if (obj.offsetParent){
		while (obj.offsetParent){
			y += obj.offsetTop
			obj = obj.offsetParent;
		}
		return y;
	} else {
		return obj.y;
	}
}
  
function trim(str) {
  var newStr = str.replace( /^\s+/g, "" ); 
  return newStr.replace( /\s+$/g, "" );
}
  
  
/*
 * Hides/shows the SELECT widgets for a specific area of the screen
 * (the area of popup box). This is needed because in IE the SELECTs
 * show through the pop-up box, so we have to hide/show them manually
 */
function setSelectVisibilityForElement(visi, elementID){
	elem = document.getElementById(elementID);
	startX = getX(elem);
	endX = startX + elem.clientWidth;
	startY = getY(elem);
	endY = startY + elem.clientHeight;
	
	pageSelects = document.getElementsByTagName("select");
	for (i = 0; i < pageSelects.length; i++) {
		if (visi == "hidden") {
				objStartX = getX(pageSelects[i]);
				objStartY = getY(pageSelects[i]);
				objEndX = objStartX + pageSelects[i].clientWidth;
				objEndY = objStartY + pageSelects[i].clientHeight;
				// If this select intersects the popup window, hide it
				if(((objStartX > startX && objStartX < endX) || 
						(objEndX > startX && objEndX < endX)) &&
					((objStartY > startY && objStartY < endY) || 
						(objEndY > startY && objEndY < endY))) {
					pageSelects[i].style.visibility = "hidden";
				} else {
					// It does not intersect
					pageSelects[i].style.visibility = "visible";
				}
		} else {
			// show all selects
			pageSelects[i].style.visibility = visi;
		}
	}
}

/**
 * Encode a string so it can be passed as a parameter in a URL
 */
function URLEncode(str) {
	return escape(str).
	replace(/\+/g, '%2B').
	replace(/\"/g,'%22').
	replace(/\'/g, '%27').
	replace(/\//g,'%2F');

//	return escape(str);
}

/**
 * Decode a string previously encoded with URLEncode
 */
function URLDecode(str) {
	return unescape(str);
}

/**
 * Show the component with the specified name
 */
function show(name) {
	$(name).style.display = "";
}

/**
 * Hide the component with the specified name
 */
function hide(name) {
	$(name).style.display = "none";
}

/***********************
 *    XML Utilities    *
 ***********************/
 
 /**
  * Returns an XML node from a string
  */
 function parseXML(xmlString) {
	return Try.these(
		function() { return new DOMParser().parseFromString(xmlString, 'text/xml'); },
		function() { var xmldom = new ActiveXObject('Microsoft.XMLDOM'); xmldom.async='false'; xmldom.loadXML(xmlString); return xmldom;},
		function() { return getDOMFromStringSafari(xmlString); }
	);
 } 


/**
 * Returns the first node found from the specified XML node
 * with the specified name, or null if no such node exists
 */ 
 function getNode(xmlNode, nodeName) {
 	var nodes = xmlNode.getElementsByTagName(nodeName);
	if ((nodes != null) && (nodes.length > 0)) {
		return nodes.item(0);
	}
	return null;
 }

/**
 * Returns the value of the first node found from the specified XML node
 * with the specified name, or null if no such node exists
 */ 
function getValueForNode(xmlNode, nodeName) {
	var nodes = xmlNode.getElementsByTagName(nodeName);
	if ((nodes != null) && (nodes.length > 0)) {
		return nodes[0].firstChild.nodeValue;
	}
	return null;
} 

/*
function getDOMFromStringSafari(xmlString) {
	var url = "data:text/xml;charset=utf-8," + encodeURIComponent(xmlString);
	
	var req = new XMLHttpRequest();
	req.open("GET", url);
	req.onload = function() { handleResponse(req) }
	req.send(null);
	var dom;
	function handleResponse(req) {
	    dom = req.responseXML;
		alert("DOM internal -> " + dom);
	}
	alert("DOM -> " + dom);
}
 */
