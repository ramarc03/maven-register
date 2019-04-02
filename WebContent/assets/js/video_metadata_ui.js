var video_metadata_ui = {
	buidMetadataUI : function(currentVideo) {
		var featuredRegister = 
			[{"title":"How to Authenticate to MyAccess with your MyAccess Credential","vid":"myaccess-authenticate-email","image_name":"authenticate-email_thumb"},
			 {"title":"How to Authenticate to MyAccess with your PIV card","vid":"myaccess-authenticate-piv","image_name":"authenticate-piv_thumb"}, 
			 {"title":"How to reset your MyAccess PIN","vid":"myaccess-reset-pin","image_name":"reset-pin_thumb"},
			 {"title":"How to change your MyAccess security questions or PIN","vid":"myaccess-manage-profile","image_name":"manage-profile_thumb"}];
		var registerMetaData = {"title":"How to register for a MyAccess Credential", "runtime":"2.01", "vid":"myaccess-register", "size":"2.97 MB", "featured":featuredRegister, "image_name":"register_thumb"};
		
		var featuredAuthenticateEmail = 
			[{"title":"How to register for a MyAccess Credential","vid":"myaccess-register","image_name":"register_thumb"},
			 {"title":"How to Authenticate to MyAccess with your PIV card","vid":"myaccess-authenticate-piv","image_name":"authenticate-piv_thumb"},
			 {"title":"How to reset your MyAccess PIN","vid":"myaccess-reset-pin","image_name":"reset-pin_thumb"},
			 {"title":"How to change your MyAccess security questions or PIN","vid":"myaccess-manage-profile","image_name":"manage-profile_thumb"}];
		var authenticateEmailMetaData = {"title":"How to Authenticate to MyAccess with your MyAccess Credential", "runtime":"0:48", "vid":"myaccess-authenticate-email", "size":"1.05 MB", "featured":featuredAuthenticateEmail, "image_name":"authenticate-email_thumb"};
		
		var featuredAuthenticatePiv = 
			[{"title":"How to register for a MyAccess Credential","vid":"myaccess-register","image_name":"register_thumb"},
			 {"title":"How to Authenticate to MyAccess with your MyAccess Credential","vid":"myaccess-authenticate-email","image_name":"authenticate-email_thumb"},
			 {"title":"How to reset your MyAccess PIN","vid":"myaccess-reset-pin","image_name":"reset-pin_thumb"},
			 {"title":"How to change your MyAccess security questions or PIN","vid":"myaccess-manage-profile","image_name":"manage-profile_thumb"}];
		var authenticatePivMetaData = {"title":"How to Authenticate to MyAccess with your PIV card", "runtime":"1:45", "vid":"myaccess-authenticate-piv", "size":"1.81 MB", "featured":featuredAuthenticatePiv, "image_name":"authenticate-piv_thumb"};
		
		var featuredAuthenticatePin = 
			[
			 {"title":"How to register for a MyAccess Credential","vid":"myaccess-register","image_name":"register_thumb"},
			 {"title":"How to Authenticate to MyAccess with your MyAccess Credential","vid":"myaccess-authenticate-email","image_name":"authenticate-email_thumb"},
			 {"title":"How to Authenticate to MyAccess with your PIV card","vid":"myaccess-authenticate-piv","image_name":"authenticate-piv_thumb"},
			 {"title":"How to change your MyAccess security questions or PIN","vid":"myaccess-manage-profile","image_name":"manage-profile_thumb"}];
		var resetPinMetaData = {"title":"How to reset your MyAccess PIN", "runtime":"2.17", "vid":"myaccess-reset-pin", "size":"2.79 MB", "featured":featuredAuthenticatePin, "image_name":"reset-pin_thumb"};
		
		var featuredManageProfile = 
			[
			 {"title":"How to register for a MyAccess Credential","vid":"myaccess-register","image_name":"register_thumb"},
			 {"title":"How to Authenticate to MyAccess with your MyAccess Credential","vid":"myaccess-authenticate-email","image_name":"authenticate-email_thumb"},
			 {"title":"How to Authenticate to MyAccess with your PIV card","vid":"myaccess-authenticate-piv","image_name":"authenticate-piv_thumb"},
			 {"title":"How to reset your MyAccess PIN","vid":"myaccess-reset-pin", "image_name":"reset-pin_thumb"}];
		var manageProfileMetaData = {"title":"How to change your MyAccess security questions or PIN", "runtime":"2.33", "vid":"myaccess-manage-profile", "size":"3.17 MB", "featured":featuredManageProfile, "image_name":"manage-profile_thumb"};
		
		var videoMapper = {};
		videoMapper["myaccess-register"] = registerMetaData;
		videoMapper["myaccess-authenticate-email"] = authenticateEmailMetaData;
		videoMapper["myaccess-authenticate-piv"] = authenticatePivMetaData;
		videoMapper["myaccess-reset-pin"] = resetPinMetaData;
		videoMapper["myaccess-manage-profile"] = manageProfileMetaData;
		document.write(videoMapper[currentVideo].title + "</small></h2> <br>" +
				"<p class=\"length\">May 2, 2014 | Running time " + videoMapper[currentVideo].runtime + "</p><br>" +
				"<p>" + videoMapper[currentVideo].title + "</p><br>" +
				"<h3>Share This VIDEO</h3>" +  
				"<p class=\"join\"><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].vid + "\">http://www.faa.gov/v_ondemand/" + videoMapper[currentVideo].vid + ".mp4</a></p><br>" +
				"<h3>Download</h3>" +
				"<p class=\"join\"> <a href=\"http://www.faa.gov/v_ondemand/" + videoMapper[currentVideo].vid + ".mp4\">MP4</a> ( " + videoMapper[currentVideo].size + " )</p>" + 
			"</div>" +
			"</div>" +
			"<div id=\"featuredMedia\" class=\"roundAll\">" +
				"<h2>Featured Media</h2>" +
				"<div class=\"scroller\">" +
					"<ul>" +										
						"<li class=\"first\"><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[0].vid + "\" class=\"media-link\"><img src=\"assets/images/" + videoMapper[currentVideo].featured[0].image_name + ".jpg\" alt=\"" + videoMapper[currentVideo].featured[0].title + "\" width=\"130\" height=\"90\"></a><br><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[0].vid + "\" class=\"media-link\">" + videoMapper[currentVideo].featured[0].title + "</a></li>" +
						"<li><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[1].vid + "\" class=\"media-link\"><img src=\"assets/images/" + videoMapper[currentVideo].featured[1].image_name + ".jpg\" alt=\"" + videoMapper[currentVideo].featured[1].title + "\" width=\"130\" height=\"90\"></a><br><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[1].vid + "\" class=\"media-link\">" + videoMapper[currentVideo].featured[1].title + "</a></li>" +
						"<li><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[2].vid + "\" class=\"media-link\"><img src=\"assets/images/" + videoMapper[currentVideo].featured[2].image_name + ".jpg\" alt=\"" + videoMapper[currentVideo].featured[2].title + "\" width=\"130\" height=\"90\"></a><br><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[2].vid + "\" class=\"media-link\">" + videoMapper[currentVideo].featured[2].title + "</a></li>" +
						"<li><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[3].vid + "\" class=\"media-link\"><img src=\"assets/images/" + videoMapper[currentVideo].featured[3].image_name + ".jpg\" alt=\"" + videoMapper[currentVideo].featured[3].title + "\" width=\"130\" height=\"90\"></a><br><a href=\"video_helper.html?helpvideo=" + videoMapper[currentVideo].featured[3].vid + "\" class=\"media-link\">" + videoMapper[currentVideo].featured[3].title + "</a></li>" +
					"</ul>");

	},
	
    getVideoTitle : function(currentVideo) {
    	var videoTitles = {};
    	videoTitles["myaccess-register"] = "How to register for a MyAccess Credential";
    	videoTitles["myaccess-authenticate-email"] = "How to Authenticate to MyAccess with your MyAccess Credential";
    	videoTitles["myaccess-authenticate-piv"] = "How to Authenticate to MyAccess with your PIV card";
    	videoTitles["myaccess-reset-pin"] = "How to reset your MyAccess PIN";
    	videoTitles["myaccess-manage-profile"] = "How to change your MyAccess security questions or PIN";
    	
    	return videoTitles[currentVideo];
    }
};
