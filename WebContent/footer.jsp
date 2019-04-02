<table style="width: 100%">
	<tr>
		<td>
			<script>
				var isMobileDevice = true;
			   	var LIST_DESKTOPS_LAPTOPS = ["win16", "win32", "win64", "os/2", "macintosh", "macintel", "macppc", "mac68k", "freebsd i386", "freebsd amd64", "linux i686 x11", "linux x86_64 x11", "sunos", "sunos i86pc", "sunos sun4u", "hp-ux", "webtv os", "x11"];
			   	for(var i = 0; i < LIST_DESKTOPS_LAPTOPS.length; i++) {
			       	if(navigator.platform.toLowerCase() === LIST_DESKTOPS_LAPTOPS[i]) {
				       	isMobileDevice = false;
				       	break;
			       	}
			   	}
			   	if( ! isMobileDevice) {
			   		//document.write('<h2 class="left"><a class="loginHelp" href="login_help.html">Need Help Logging in?</a></h2>');
			   	}
			   	else { // it is a mobile device
			   		//document.write('<h2 class="left"><a class="loginHelpmobile" href="login_help_mobile.html">Need Help Logging in?</a></h2> ');
			   	}
			</script>
		</td>
		<td>
		</td>
	</tr>
</table>
<div id="bottom">
	<span id="divot"></span>
	<p>You are accessing a U.S. Government information system, which includes (1) this computer, (2) this computer network, (3) all computers connected to this network, and (4) all devices and storage media attached to this network or to a computer on this network. This information system is provided for U.S. Government-authorized use only. Unauthorized or improper use of this system may result in disciplinary action, as well as civil and criminal penalties. By using this information system, you understand and consent to the following. (1) You have no reasonable expectation of privacy regarding any communication or data transiting or stored on this information system. At any time, and for any lawful government purpose, the government may monitor, intercept, and search and seize any communications or data transiting or stored on this information system. (2) Any communications or data transiting or stored on this information system may be disclosed or used for any lawful government purpose.</p>
</div> <!-- /bottom -->
	
<script src="assets/js/jquery/1.10.2/jquery.min.js"></script>
<script src="assets/js/jquery/ui/1.10.3/jquery-ui.min.js"></script>
<script src="assets/js/libs/qTip2/2.2.0/jquery.qtip.min.js"></script> 
<script src="assets/js/libs/qTip2/myaccess.tooltips.min.js"></script>
<script src="assets/js/jquery.template.min.js"></script>
<script src="assets/js/myaccess.video.controller.min.js"></script>



<script>
function setfocus(targetId) {
	   var focusElement = document.getElementById(targetId);
	   if (focusElement) focusElement.focus();
}
</script>
