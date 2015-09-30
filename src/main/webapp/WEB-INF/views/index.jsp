<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Dashboard</title>
	<link href="<c:url value="/resources/form.css" />" rel="stylesheet"  type="text/css" />		
	<link href="<c:url value="/resources/jqueryui/1.8/themes/base/jquery.ui.core.css" />" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/resources/jqueryui/1.8/themes/base/jquery.ui.theme.css" />" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/resources/jqueryui/1.8/themes/base/jquery.ui.tabs.css" />" rel="stylesheet" type="text/css"/>
	
	<!--
		Used for including CSRF token in JSON requests
		Also see bottom of this file for adding CSRF token to JQuery AJAX requests
	-->
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<h1><a href="<c:url value="/" />">VDV Compare</a></h1>
<p>Simple way to make quick decisions</p>
<div id="tabs">
	<ul>
		<li><a href="#voice">Voice</a></li>
		<li><a href="#data">Data</a></li>
		<li><a href="#video">Video</a></li>
		<li><a href="#bundle">Bundle Offers</a></li>		
		<li><a href="#promo">Promotional Offers</a></li>
		<li><a href="#seasonal">Seasonal Offers</a></li>
    </ul>
    <div id="voice">
		<h2>Voice Only Products and Plans</h2>
		<p>
			See the <code>org.springframework.samples.mvc.mapping</code> package for the @Controller code
		</p>		
	</div>
	<div id="data">
		<h2>Data Only Products and Plans</h2>
		<p>
			See the <code>org.springframework.samples.mvc.mapping</code> package for the @Controller code
		</p>		
	</div>
	<div id="video">
		<h2>Video Only Products and Plans</h2>
		<p>
			See the <code>org.springframework.samples.mvc.data</code> package for the @Controller code
		</p>
	</div>			
	<div id="bundle">
		<h3>Bundle Offers</h3>	
		<p>
			See the <code>org.springframework.samples.mvc.data</code> package for the @Controller code
		</p>		
	</div>
	<div id="promo">
		<h3>Promotional Offers</h3>	
		<p>
			See the <code>org.springframework.samples.mvc.data</code> package for the @Controller code
		</p>
	</div>
	<div id="seasonal">
		<h2>Seasonal Offers</h2>
		<p>
			See the <code>org.springframework.samples.mvc.response</code> package for the @Controller code
		</p>			
	</div>	
</div>
<script type="text/javascript" src="<c:url value="/resources/jquery/1.6/jquery.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqueryform/2.8/jquery.form.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.core.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.widget.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.tabs.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/json2.js" />"></script>
<script>
	MvcUtil = {};
	MvcUtil.showSuccessResponse = function (text, element) {
		MvcUtil.showResponse("success", text, element);
	};
	MvcUtil.showErrorResponse = function showErrorResponse(text, element) {
		MvcUtil.showResponse("error", text, element);
	};
	MvcUtil.showResponse = function(type, text, element) {
		var responseElementId = element.attr("id") + "Response";
		var responseElement = $("#" + responseElementId);
		if (responseElement.length == 0) {
			responseElement = $('<span id="' + responseElementId + '" class="' + type + '" style="display:none">' + text + '</span>').insertAfter(element);
		} else {
			responseElement.replaceWith('<span id="' + responseElementId + '" class="' + type + '" style="display:none">' + text + '</span>');
			responseElement = $("#" + responseElementId);
		}
		responseElement.fadeIn("slow");
	};
	MvcUtil.xmlencode = function(xml) {
		//for IE 
		var text;
		if (window.ActiveXObject) {
		    text = xml.xml;
		 }
		// for Mozilla, Firefox, Opera, etc.
		else {
		   text = (new XMLSerializer()).serializeToString(xml);
		}			
		    return text.replace(/\&/g,'&'+'amp;').replace(/</g,'&'+'lt;')
	        .replace(/>/g,'&'+'gt;').replace(/\'/g,'&'+'apos;').replace(/\"/g,'&'+'quot;');
	};
</script>
<script type="text/javascript">
$(document).ready(function() {
	$("#tabs").tabs();

	// Append '#' to the window location so "Back" returns to the selected tab
	// after a redirect or a full page refresh (e.g. Views tab).

	// However, note this general disclaimer about going back to previous tabs: 
	// http://docs.jquery.com/UI/API/1.8/Tabs#Back_button_and_bookmarking

	$("#tabs").bind("tabsselect", function(event, ui) { window.location.hash = ui.tab.hash; });
});
</script>
</body>
</html>