if ((window.location.hostname.indexOf(".gov")) >= 0){
	var srcUrl = ""; 
	
	if(window.env  == "production"){
	  var srcUrl = "//gateway.foresee.com/sites/sec-gov/production/gateway.min.js";
	}else{
	  var srcUrl = "//gateway.foresee.com/sites/sec-gov/staging/gateway.min.js";
	};
	// 
	// // ForeSee Embed Script v2.00
	// DO NOT MODIFY BELOW THIS LINE *****************************************
	;(function (g) {
	var d = document, am = d.createElement('script'), h = d.head || d.getElementsByTagName("head")[0], fsr = 'fsReady',
	    aex = {
	  "src": srcUrl,
	  "type": "text/javascript",
	  "async": "true",
	  "data-vendor": "fs",
	  "data-role": "gateway"
	};
	for (var attr in aex){am.setAttribute(attr, aex[attr]);}h.appendChild(am);g[fsr] = function () {var aT = '__' + fsr + '_stk__';g[aT] = g[aT] || [];g[aT].push(arguments);};
	})(window);
	// DO NOT MODIFY ABOVE THIS LINE *****************************************
}