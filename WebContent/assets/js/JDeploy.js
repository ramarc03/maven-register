/* 
This file is a modified version of "deployJava.js" provided by Sun Microsystems, Inc. 
The original copyright notice is provided below.
*/
 
/*
 * Copyright (c) 2009, 2010 Sun Microsystems, Inc.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 *   - Neither the name of Sun Microsystems nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

 
var JDeploy = new Object();

JDeploy.debug = false;
JDeploy.browser = null;
JDeploy.browserFamily = null;
JDeploy.JavaURL = 'http://www.java.com/en/download/';
JDeploy.pluginID = 'deployPlugin';
JDeploy.mechanism = '';

JDeploy.log = function(str){
   if(JDeploy.debug){
      alert(str);
   }
}

JDeploy.init = function(){
   JDeploy.initBrowser();
}


JDeploy.initBrowser = function(){
   var ua = navigator.userAgent;
   if(ua == null){
      JDeploy.log('Err: No User Agent');
      return;
   }
   JDeploy.log('User Agent: ' + ua);
   ua = ua.toLowerCase();
   // Safari contains mozilla,
   // Chrome contains both mozilla and safari.
   var f, b;
   if (ua.indexOf('msie') != - 1) {
      b = 'MSIE';
   }
   else if (ua.indexOf('firefox') != - 1) {
      b = 'Firefox';
   }
   else if (ua.indexOf('chrome') != - 1) {
      b = 'Chrome';
   }
   else if (ua.indexOf('safari') != - 1) {
      b = 'Safari';
   }
   else if (ua.indexOf('mozilla') != - 1) {
      b = 'Other';
   }
   else if (ua.indexOf('opera') != - 1) {
      b = 'Opera';
   }
   if(b != null){
      f = (b == 'MSIE' ? 'MSIE Family' : 'Netscape Family');
   }
   else{
      b = 'Unknown';
      f = 'Unknown';
   }

   JDeploy.log('Browser: ' + f + '/' + b );
   JDeploy.browserFamily = f;
   JDeploy.browser = b;
}


JDeploy.installJRE = function(){
   JDeploy.writePlugin();
   // check if plugin exists and is usable
   var plugin = JDeploy.getPlugin();
   if(plugin && plugin.jvms){
      JDeploy.log('Installing via plugin...');
      plugin.installLatestJRE();
   }
   else{
      JDeploy.log('Installing via URL...');
      location.href = JDeploy.JavaURL;
   }
}

JDeploy.hasMinVersion = function(minVersion){
   JDeploy.log('hasMinversion()');
   var versions = JDeploy.getVersions();
   JDeploy.log('Versions: ' + versions);
   for(var i = 0;i < versions.length; i ++ ){
      var found = JDeploy.compare(versions[i], minVersion);
      if(found){
         return true;
      }
   }
   return false;
}

JDeploy.getLatestVersion = function(){
   JDeploy.log('getLatestVersion()');
   var versions = JDeploy.getVersions();
   JDeploy.log('Versions: ' + versions);
   if(versions.length == 0){
		return '0.0';
   }
   var latest = versions[0];
   for(var i = 1;i < versions.length; i ++ ){
      var found = JDeploy.compare(versions[i], latest);
      if(found){
         latest = versions[i];;
      }
   }
   return latest;
}


/* returns true if v1 >= v2 */
JDeploy.compare = function(v1, v2) {
   var a = JDeploy.normalise(v1);
   var b = JDeploy.normalise(v2);
   var res = (a[0] != b[0] ? a[0] > b[0] : (a[1] != b[1] ? a[1] > b[1] : (a[2] >= b[2])));
   return res;
}

JDeploy.normalise = function (v){
   // Get rid of updates also
   var n = v.split('_')[0].split('.');
   for (var i = 0; i < n.length; i ++ ) {
      n[i] = Number(n[i]);
   }
   if (n.length == 2) {
      n[2] = 0;
   }
   return n;
}

JDeploy.getVersions = function (){
   JDeploy.log('getVersions()');

   var arr = new Array();
   var f = JDeploy.browserFamily;
   var b = JDeploy.browser;
   
   if( f == 'MSIE Family'){
      arr = JDeploy.getActiveXVersions();
      if(arr.length != 0){
		 JDeploy.mechanism = 'ActiveX';
         return arr;
      }
	  //This method may cause IE to hang (as it writes some <object> tag that hangs). 
	  // Comment the code below, if this happens.
	  //Commenting will reduce our capability to detect Java version
      arr = JDeploy.getPluginVersions();
      if(arr.length != 0){
		 JDeploy.mechanism = 'Plugin';
         return arr;
      }
   }

   // FF, Chrome, etc
   // Take care of Safari browser too
   if( f == 'Netscape Family' || b == 'Safari'){
   
	
      // JPI versions
      arr = JDeploy.getMimeVersions(true);
      if(arr.length != 0){
		 JDeploy.mechanism = 'Mime';
         return arr;
      }
      // Non JPI versions
      arr = JDeploy.getMimeVersions(false);
      if(arr.length != 0){
		 JDeploy.mechanism = 'Mime';
         return arr;
      }
      arr = JDeploy.getPluginVersions();
      if(arr.length != 0){
		 JDeploy.mechanism = 'Plugin';
         return arr;
      }
   }
  
   arr = new Array();
   return arr;
   
   /*	
   // Try pathological cases
   var b = JDeploy.browser;
   var ua = navigator.userAgent;
   ua = (ua == null ? '' : ua.toLowerCase());
   var isWin6Or7 = (ua.indexOf('windows nt 6') > - 1) || (ua.indexOf('windows nt 7') > - 1);

   // Special case for Chrome on Windows 7
   if(b == 'Chrome' && isWin6Or7){
      JDeploy.log('Chrome on Windows 6 or 7');
      arr.push('1.6.0');
   }
   // TODO handle Safari and Opera
   */

}

/* For Safari browser */
JDeploy.getPluginsArray = function() {

	if ((!navigator.plugins) || (!navigator.plugins.length)) {
	    return false;
	}
	var platform = navigator.platform.toLowerCase();

	for (var i = 0; i < navigator.plugins.length; ++i) {
	    s = navigator.plugins[i].description;
	    if (s.search(/^Java Switchable Plug-in (Cocoa)/) != -1) {
		// Safari on MAC
		return true;
	    } else if (s.search(/^Java/) != -1) {
		if (platform.indexOf('win') != -1) {
		    // still can't tell - opera, safari on windows
		    // return true for 1.5.0 and 1.6.0
			return true;
		}
	    }
	}
	return false;

}


/* For Netscape Family */
JDeploy.getMimeVersions = function(flag) {
   JDeploy.log('getMimeVersions(' + flag + ')');
   var mimes = navigator.mimeTypes;
   var arr = new Array();
   if (mimes == null) {
      return arr;
   }
   for (var i = 0; i < mimes.length; ++ i) {
      var s = mimes[i].type;
      var m = null;
      if(flag){
         m = s.match(/^application\/x-java-applet;jpi-version=(.*)$/);
      }
      else{
         m = s.match(/^application\/x-java-applet;version=(.*)$/);
      }
      if (m != null) {
         arr.push(m[1]);
      }
   }
   return arr;
}

/* For MSIE */
JDeploy.getActiveXVersions = function(){
   JDeploy.log('getActivXVersions()');
   var arr = new Array();
   if ( ! ActiveXObject) {
      return arr;
   }
   var versions = new Array('1.7.0', '1.6.0', '1.5.0', '1.4.2');
   for(var i = 0; i < versions.length; i ++ ){
      var objName = 'JavaWebStart.isInstalled.' + versions[i] + '.0';
      try{
         var activeX = new ActiveXObject(objName);
         if(activeX != null){
            arr.push(versions[i]);
         }
      }
      catch(e){
      }
   }
   return arr;
}

/* For MSIE & Netscape Family, sans Chrome, Safari & Opera */
JDeploy.getPluginVersions = function(){
   JDeploy.log('getPluginVersions()');
   var arr = new Array();
   JDeploy.writePlugin();
   // Check if plugin exists and is usable
   var plugin = JDeploy.getPlugin();

   if(plugin == null || plugin.jvms == null){
      return arr;
   }
   var jvms = plugin.jvms;
   for (var i = 0; i < jvms.getLength(); i ++ ) {
      arr.push(jvms.get(i).version);
   }
   return arr;
}


JDeploy.getPlugin = function(){
   return document.getElementById(JDeploy.pluginID);
}

JDeploy.writePlugin = function() {
   if(JDeploy.getPlugin() != null){
      return;
   }
   JDeploy.log('writePlugin()');
   var b = JDeploy.browser;
   var f = JDeploy.browserFamily;
   if (b == 'MSIE') {
      JDeploy.writeObject();
   }
   if (f == 'Netscape Family'){
      // b != 'Chrome' &&
      if(b != 'Safari' && b != 'Opera'){
         JDeploy.writeEmbed();
      }
   }
}

JDeploy.writeObject = function() {
   if(JDeploy.getPlugin() != null){
      return;
   }
   JDeploy.log('writeObject()');
   var str = '<object ';
   str +=  'id="' + JDeploy.pluginID + '" ';
   str +=  'classid="clsid:CAFEEFAC-DEC7-0000-0000-ABCDEFFEDCBA" ';
   str +=  'codebase="" ';
   str +=  'width="0" height="0" ';
   str +=  '></object>';
   JDeploy.create(str);
}

JDeploy.writeEmbed = function() {
   if(JDeploy.getPlugin() != null){
      return;
   }
   JDeploy.log('writeEmbed()');
   var m1 = 'application/java-deployment-toolkit';
   var m2 = 'application/npruntime-scriptable-plugin;JDeploymentToolkit';
   var has1 = false;
   var has2 = false;
   // Check available mime types
   var mimes = navigator.mimeTypes;
   if(mimes == null){
      return;
   }
   for (var i = 0; i < mimes.length;i ++ ) {
      if (mimes[i].type == m1) {
         has1 = true;
      }
      if (mimes[i].type == m2) {
         has2 = true;
      }
   }
   // Write embed tag if mime type found
   var m = (has1 ? m1 : (has2 ? m2 : null));
   if(m != null){
      var str = '<embed id="' + JDeploy.pluginID + '" type="' + m + '" hidden="true"></embed>';
      JDeploy.create(str);
   }
}


JDeploy.create = function(str){
   // Do not use document.write(), it's obnoxiously buggy
   var b = document.getElementsByTagName('body');
   var s = document.getElementsByTagName('script');
   var p = document.createElement('p');
   if(b == null || b.length == 0){
      s[0].parentNode.appendChild(p);
   }
   else{
      b[0].appendChild(p);
   }
   p.innerHTML = str;
}

JDeploy.init();
