	// Regular expression patterns
	var phoneRegex = {
	  phone: {
	    us: /^1?(\d{3})(\d{3})(\d{4})$/,
	  }
	};
	
	var zipRegex = {
	  zip: {
	    us:  /^1?(\d{5})$/,
	  }
	};
	var ssnRegex = {
	  ssn: {
	    us:  /^1?(\d{3})(\d{2})(\d{4})$/,
	  }
	};	
	var validTextRegex = {
	  withSpace: {
	    us:  /^[a-zA-Z0-9 ,.\'-]*$/,
	  },
	  address: {
	    us:  /^[a-zA-Z0-9 ,.\'/#-]*$/,
	  },
	  cityState: {
	    us:  /^[a-zA-Z0-9 ,.\'-]*$/,
	  }
	};

	function uuidv4() {
  		return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    	var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    	return v.toString(16);
  		});
	}
	function focusTonext(){
		   $("input:visible").keyup(function(){
		        if($(this).val().length==$(this).attr("maxlength")){
		        	if(($(this).attr("id")=="personal_ccn") ){
	        			$(":input")[$(":input").index(document.activeElement) + 1].focus();
	        		}else{
		               $(":input")[$(":input").index(document.activeElement) + 1].focus();			        		
		        	}
		        	return false;
		        }
	    })
	}
	function headPage(){
		
	    $("a").on('focusout', function(e){
	    	if($(this).attr("id")=="departmentid"){
					e.preventDefault(); 				
					$("#departmentid").css('outline-color', '');
					$('#departmentid').css('outline-style', '');
 					$('#departmentid').css('outline-width', '');
 			}else if($(this).attr("id")=="whatIs"){ 
	    			e.preventDefault();
 					$('#whatIs').css('outline-color', '');
					$('#whatIs').css('outline-style', '');
					$('#whatIs').css('outline-width', '');
			}
	    })
		$("a").on('focus', function(e){
    		if($(this).attr("id")=="departmentid"){
					e.preventDefault(); 				
					$("#departmentid").css('outline-color', 'Gray');
					$('#departmentid').css('outline-style', 'dotted');
 					$('#departmentid').css('outline-width', 'thin');
 			}else if($(this).attr("id")=="whatIs"){ 
	    			e.preventDefault();
 					$('#whatIs').css('outline-color', 'Gray');
					$('#whatIs').css('outline-style', 'dotted');
					$('#whatIs').css('outline-width', 'thin');
				}
		});
	}
	function personalPage(){
	    $("a").on('focusout', function(e){
	    		if($(this).attr("id")=="whyneed"){ 
	    			e.preventDefault();
	    		  	$("#whyneed").css('outline-color', '');
						$('#whyneed').css('outline-style', '');
 					$('#whyneed').css('outline-width', '');
				}else if($(this).attr("id")=="privacy2"){ 
						e.preventDefault();
						$("#privacy2").css('outline-color', '');
						$('#privacy2').css('outline-style', '');
 					$('#privacy2').css('outline-width', '');
				}
				else if($(this).attr("id")=="privacy1"){ 
						e.preventDefault();
						$("#privacy1").css('outline-color', '');
						$('#privacy1').css('outline-style', '');
 					$('#privacy1').css('outline-width', '');
				}
	    })
		$("a").on('focus', function(e){
				if($(this).attr("id")=="whyneed"){ 
	    			e.preventDefault();
	    		  	$("#whyneed").css('outline-color', 'Gray');
						$('#whyneed').css('outline-style', 'dotted');
 					$('#whyneed').css('outline-width', 'thin');
 					$('#whyneed').qtip({
						content: {
							text: "Loading&hellip;",
							ajax: {
								url: "whyneed.html",
								dataType: 'html',
								loading: false,
								type: "GET"
							}
						},
						position: {
							my: "top right",
							at: "bottom center",
							target: $('#whyneed'),
							adjust: {
							y: 2
						}
					},
					show: {
						event: "keyup"
					},
					hide: {
						//delay: 500,
						//fixed: true
						event: 'keydown'
					},
					style: {
						classes: "ui-tooltip-cream ui-tooltip-rounded ui-tooltip-shadow",
						tip: {
							corner: true,
							offset: 10,
							width: 12
						}
					}
				}); 
				}else if($(this).attr("id")=="privacy2"){ 
						e.preventDefault();
						$("#privacy2").css('outline-color', 'Gray');
						$('#privacy2').css('outline-style', 'dotted');
 					$('#privacy2').css('outline-width', 'thin');
 				 	$('#privacy2').qtip({
						content: {
						text: "Loading&hellip;",
						ajax: {
							url: "privacy.html",
							dataType: 'html',
							loading: false,
							type: "GET"
						}
					},
					position: {
						my: "top right",
						at: "bottom right",
						target: $('#privacy2'),
						adjust: {
							x: -20,
							y: 5
						}
					},
					show: {
						event: "keyup"
					},
					hide: {
						//delay: 100,
						//fixed: true
						event: 'keydown'
					},
					style: {
						margin: '10px',
						padding: '10px',
						classes: "ui-tooltip-cream ui-tooltip-rounded ui-tooltip-shadow ui-tooltip-wide",
						tip: {
							corner: true,
							offset: 10,
							width: 12
						},
						width: '600px'

					}
				});
				}else if($(this).attr("id")=="privacy1"){ 
						e.preventDefault();
						$("#privacy1").css('outline-color', 'Gray');
						$('#privacy1').css('outline-style', 'dotted');
 					$('#privacy1').css('outline-width', 'thin');
 						 					$('#privacy1').qtip({
						content: {
						text: "Loading&hellip;",
						ajax: {
							url: "privacyIdentity.html",
							dataType: 'html',
							loading: false,
							type: "GET"
						}
					},
					position: {
						my: "top right",
						at: "bottom right",
						target: $('#privacy1'),
						adjust: {
							x: -20,
							y: 5
						}
					},
					show: {
						event: "keyup"
					},
					hide: {
						//delay: 100,
						//fixed: true
						event: 'keydown'
					},
					style: {
						margin: '10px',
						padding: '10px',
						classes: "ui-tooltip-cream ui-tooltip-rounded ui-tooltip-shadow ui-tooltip-wide",
						tip: {
							corner: true,
							offset: 10,
							width: 12
						},
						width: '600px'

					}
				});
				}
		});
	}
	
	function personalPageOpeartions(){
		//$("#myBar").width("0%");
		
		$("#personal_txtssn").hide();
	    $("#personal_chkshow").change(function() {	    	
	        var isChecked = $(this).prop("checked");
	        if (isChecked) {
	        	document.getElementById("personal_ssn").attributes["type"].value = "text";
	
	        } else {
	        	document.getElementById("personal_ssn").attributes["type"].value = "password";
	        }
	
	    });
			    
	    var hidestate = $("#personal_stateHide" ).val();
	    if($("#personal_stateHide" ).val().length > 0 && $("#personal_stateHide" ).val() != "null")		 
	    	$("#personal_hstate").val(hidestate);
	    
	    var hidesuffix = $("#personal_suffixhide" ).val();
	    if($("#personal_suffixhide" ).val().length > 0 && $("#personal_suffixhide" ).val() != "null")
	    	$("#personal_suffix").val(hidesuffix);
			    
	    {
	    	
	    	var element_mname=$("#personal_mname");
			element_mname.addClass("valid");
			
			var element_suffix=$("#personal_suffix");
			element_suffix.addClass("valid");

			var element_mtype=$("#personal_mtype");
			element_mtype.addClass("valid");				
			var element_ptype=$("#personal_ptype");
			element_ptype.addClass("valid");
			var element_ptype=$("#personal_card");
			element_ptype.addClass("valid");
			
			var element_mname=$("#personal_mnumber");
			element_mname.addClass("valid");
	    	var element_mname=$("#personal_pnumber");
			element_mname.addClass("valid");
							
			var element_txtssn=$("#personal_txtssn");
			element_txtssn.addClass("valid");
			
			var element_ssn=$("#personal_ssn");
			element_ssn.addClass("valid");

			
			var element_haddress2=$("#personal_haddress2");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_stateHide");
			element_haddress2.addClass("valid");
			
			var element_haddress2=$("#personal_suffixhide");
			element_haddress2.addClass("valid");
	    }
	    {
	   		var form_data=$("#personal").serializeArray(); 
	   		for (var input in form_data){
	   			var element=$("#personal_"+form_data[input]["name"]);
	   			if(element.val().length > 0){
	   				element.addClass("valid");
	   			}
	   		}
	
	    
	    }


		$("#personal_email").on("input", function() {
				var input=$(this);
				//var re = /^[-a-zA-Z0-9~!$%^&*_=+}{\"?]+(\.[-a-z0-9~!$%^&*_=+}{\"?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z][A-Z]})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/;
				//var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					var re=/^[a-zA-Z0-9_+&*\'-]+(?:\.[a-zA-Z0-9_+&*\'-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
				var is_email=re.test(input.val()); 
				var lfaa = input.val().lastIndexOf("@faa.gov");
				var ldot = input.val().lastIndexOf("@dot.gov");
				if(lfaa != -1)
				 is_email= false;
				if(ldot != -1)
				 is_email= false;
				if(is_email){input.removeClass("invalid").addClass("valid");}
				else{input.removeClass("valid").addClass("invalid");}
		});
	    
		$("#personal_fname").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.withSpace[cc];
		    var is_fname = (value.length > 0 && re.test(value));		
			if(is_fname){input.removeClass("invalid").addClass("valid");}				
			else{input.removeClass("valid").addClass("invalid");}
		});
		$("#personal_lname").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.withSpace[cc];
		    var is_lname = (value.length > 0 && re.test(value));	
			if(is_lname){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_card").on("click", function() {
			$("#pmandate").hide();
		});
		$("#personal_ptype").on("click", function() {
			$("#pmandate").show();				
		});
		$("#personal_mtype").on("click", function() {
			$("#pmandate").show();
		});
		
		$("#personal_mname").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.withSpace[cc];
		    var is_lname = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_lname){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_pnumber").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = phoneRegex.phone[cc];
		    var is_pnumber = value.length > 9 && re.test(value);
		  	if (is_pnumber) {
		     input.val(value.replace(re, "($1) $2-$3"));
		    }
			if(is_pnumber || ($.trim(input.val()).length ==0)){
				input.removeClass("invalid").addClass("valid");}
			else{
				input.removeClass("valid").addClass("invalid");
			}
		});
		
		$("#personal_mnumber").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = phoneRegex.phone[cc];
		    var is_mnumber = value.length > 9 && re.test(value);
		  	if (is_mnumber) {
		     input.val(value.replace(re, "($1) $2-$3"));
		    }
			if(is_mnumber || ($.trim(input.val()).length ==0)){
				input.removeClass("invalid").addClass("valid");
			}else{input.removeClass("valid").addClass("invalid");}
		});

		$("#personal_ssn").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = ssnRegex.ssn[cc];
		    var is_ssn = value.length > 8 && re.test(value);
		  	if (is_ssn) {
		  	
		     input.val(value.replace(re, "$1-$2-$3"));
		    }
		  	
		    $("#personal_txtssn").val($(this).val());
		    
		    var finalSsnRegex = /^(?!(000|666|9))\d{3}-(?!00)\d{2}-(?!0000)\d{4}$/;
		    
			if( (is_ssn && finalSsnRegex.test($(this).val())) || ($.trim(input.val()).length ==0)){
				input.removeClass("invalid").addClass("valid");
				$("#personal_txtssn").removeClass("invalid").addClass("valid");
			} else{
				input.removeClass("valid").addClass("invalid");
				$("#personal_txtssn").removeClass("valid").addClass("invalid");
			}
		});
		$("#personal_txtssn").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = ssnRegex.ssn[cc];
		    var is_ssn = value.length > 8 && re.test(value);
		  	if (is_ssn) {
		  	
		     input.val(value.replace(re, "$1-$2-$3"));
		    }
		    $("#personal_ssn").val($(this).val());
		    
				var finalSsnRegex = /^(?!(000|666|9))\d{3}-(?!00)\d{2}-(?!0000)\d{4}$/;
		    
			if( (is_ssn && finalSsnRegex.test($(this).val())) || ($.trim(input.val()).length ==0)){
				input.removeClass("invalid").addClass("valid");
				$("#personal_ssn").removeClass("invalid").addClass("valid");
			} else{
				input.removeClass("valid").addClass("invalid");
				$("#personal_ssn").removeClass("valid").addClass("invalid");
			}
		});
		
		$("#personal_ccn").on("input", function() {
			var input=$(this);
			var value=$.trim(input.val());
			var regex = /[0-9][0-9][0-9][0-9][0-9]|\./;
			var is_ccn = value.length > 0 && regex.test(value);
			if(is_ccn){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});	
		
		$("#personal_birthmonth").on("input", function() {
			var input=$(this);
			var value=$.trim(input.val());
			var regex = /[0-1][0-9]|\./;
			var regexday = /[0-3][0-9]|\./;

			var element_birthday=$("#personal_birthday");
			var element_birthyear=$("#personal_birthyear");
			var element_birthmonth=$("#personal_birthmonth");
			element_birthday.removeClass("invalid").addClass("valid");
			element_birthyear.removeClass("invalid").addClass("valid");
			var is_birthmonth = value.length >0 && value < 13 && regex.test(value);
			//alert("First:"+ is_birthmonth);
			var is_birthday = true;
			var bd = element_birthday.val();
			var bm = element_birthmonth.val();
			var by = element_birthyear.val();
			//if(bm.length==1){
				//bm = "0"+bm;
				//element_birthmonth.val(bm);
				//element_birthmonth.addClass("valid");	
			//}
			if(bd.length==1){
				bd = "0"+bd;
				element_birthday.val(bd);
				element_birthday.addClass("valid");				
			}
			if(is_birthmonth){
				var bd = element_birthday.val();

				if(bd.length >0){
					//alert(bd)
					if(bd.length==1){
						bd = "0"+bd;
						element_birthday.val(bm);
					}
					//alert(value)
					if(bm == '02'){
						var by = element_birthyear.val();
						if(by.length >0){
							if(!(by % 4) && (by % 100) || !(by % 400)){
								//alert("it is leap year : " + by);
								is_birthday = bd.length >0 && bd < 30 && regexday.test(bd);
							}else{
								//alert("it is not leap year : " + by);
								is_birthday = bd.length >0 && bd < 29 && regexday.test(bd);
							}
						}
						//alert("if it is 02 : " + is_birthmonth);
					}else if(bm == '00'){
						is_birthmonth = false;
					}else if(bm == '04' || bm == '06' || bm == '09' || bm == '11'){
						is_birthday = bd.length >0 && bd < 31 && regexday.test(bd);
					}else{
						//alert(" in else : "+ value)
						if(bd=='00'){
							is_birthday = false;
						}else{
							is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
						}
						//alert("if it is odd : " + is_birthmonth);
					}
				}

			}
			if(!is_birthday){
				//alert(is_birthday + bd);
				element_birthday.removeClass("valid").addClass("invalid");
			}
			if(is_birthmonth){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_birthday").on("input", function() {
			//alert('hi');
			var input=$(this);
			var value=$.trim(input.val());
			var regex = /[0-3][0-9]|\./;
			var regexmonth = /[0-1][0-9]|\./;
			var element_birthmonth=$("#personal_birthmonth");
			var element_birthday=$("#personal_birthday");
			var element_birthyear=$("#personal_birthyear");
			element_birthmonth.removeClass("invalid").addClass("valid");
			element_birthyear.removeClass("invalid").addClass("valid");
			//alert("First:"+ is_birthday);
			var bd = element_birthday.val();
			var bm = element_birthmonth.val();
			var by = element_birthyear.val();
			var is_birthday = bd.length >0 && bd < 32 && regex.test(bd);
			var is_birthmonth = bm.length >0 && bm < 13 && regexmonth.test(bm);
			if(bm.length==1){
				bm = "0"+bm;
				element_birthmonth.val(bm);
				element_birthmonth.addClass("valid");	
			}
			//if(bd.length==1){
				//bd = "0"+bd;
				//element_birthday.val(bd);
				//element_birthday.addClass("valid");				
			//}
			if(is_birthday){
				if(bd.length >0){
					//alert(value)
					if(bm == '02'){
						if(by.length >0){
							if(!(by % 4) && (by % 100) || !(by % 400)){
								//alert("it is leap year : " + by);
								is_birthday = bd.length >0 && bd < 30 && regex.test(bd);
							}else{
								//alert("it is not leap year : " + by);
								is_birthday = bd.length >0 && bd < 29 && regex.test(bd);
							}
						}
						//alert("if it is 02 : " + is_birthmonth);
					}else if(bm == '00'){
						is_birthmonth = false;
					}else if(bm == '04' || bm == '06' || bm == '09' || bm == '11'){
						is_birthday = bd.length >0 && bd < 31 && regex.test(bd);
						//alert("if it is 04 : " + is_birthmonth);
					}else{
						//alert(" in else : "+ value)
						if(bd=='00'){
							is_birthday = false;
						}else{
							is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
						}
					}
				}

			}
			if(!is_birthmonth){
				element_birthmonth.removeClass("invalid").addClass("valid");
			}
			if(is_birthday){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		$("#personal_birthyear").on("input", function() {
			var input=$(this);
			var value=$.trim(input.val());
			var regex = /[1-2][0-9][0-9][0-9]|\./;
			var regexday = /[0-3][0-9]|\./;
			var regexmonth = /[0-1][0-9]|\./;
			var element_birthmonth=$("#personal_birthmonth");
			var element_birthday=$("#personal_birthday");
			var element_birthyear=$("#personal_birthyear");
			element_birthmonth.removeClass("invalid").addClass("valid");
			element_birthday.removeClass("invalid").addClass("valid");
			var bd = element_birthday.val();
			var bm = element_birthmonth.val();
			var by = element_birthyear.val();
			var is_birthyear = by.length > 3 && regex.test(by);
			var is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
			var is_birthmonth = bm.length >0 && bm < 13 && regexmonth.test(bm);

			//alert(is_birthday + " First:"+bd);

			if(bm.length==1){
				bm = "0"+bm;
				element_birthmonth.val(bm);
				element_birthmonth.addClass("valid");	
			}
			if(bd.length==1){
				bd = "0"+bd;
				element_birthday.val(bd);
				element_birthday.addClass("valid");				
			}
			if(is_birthyear){
				if(is_birthyear){
				    var today = new Date();
				    //alert(value+"-"+bm+"-"+bd)
				    var birthDate = new Date(value+"-"+bm+"-"+bd);
				    //alert(value+"-"+bm+"-"+bd)


				    var age = today.getFullYear() - birthDate.getFullYear();
				    //alert(age)
				    //alert(" birthDate : " + birthDate.getUTCDate() + " today : " + today.getUTCDate());
				    if (birthDate.getUTCDate() < today.getUTCDate()){
				    	//alert(" today Month : " + today.getMonth() + " birthDate Month : " + birthDate.getMonth());

					    if (today.getMonth()-1 < birthDate.getMonth()){
					    	 age--;
					    	 //alert("if if date : "+ age)
					    }
				    }else{
				    	//alert(" today Month : " + today.getMonth() + " birthDate Month : " + birthDate.getMonth());

					    if (today.getMonth() < birthDate.getMonth()){
					    	 age--;
					    	 //alert("if month : "+ age)
					    }
				    }
				    var age = today.getFullYear() - birthDate.getFullYear();
				    //alert(age);
				    var min = 5;
				    if (age > min+1) {
				    	is_birthyear = true;
				    }else{
				    	is_birthyear = false;
				    }
				}
				if(bd.length >0){

					//alert(value)
					if(bm == '02'){
						if(by.length >0){
							if(!(by % 4) && (by % 100) || !(by % 400)){
								//alert("it is leap year : " + by);
								is_birthday = bd.length >0 && bd < 30 && regexday.test(bd);
							}else{
								//alert("it is not leap year : " + by);
								is_birthday = bd.length >0 && bd < 29 && regexday.test(bd);
							}
						}
						//alert("if it is 02 : " + is_birthmonth);
					}
					else if(bm == '00'){
						is_birthmonth = false;
					}else if(bm == '04' || bm == '06' || bm == '09' || bm == '11'){
						is_birthday = bd.length >0 && bd < 31 && regexday.test(bd);
						//alert("if it is 04 : " + is_birthmonth);
					}else{
						if(bd=='00'){
							is_birthday = false;
						}else{
							is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
						}
					}
				}

			}
			if(!is_birthday){
				//alert(is_birthday + bd);
				//alert(is_birthday);
				element_birthday.removeClass("valid").addClass("invalid");
			}
			if(!is_birthmonth){
				element_birthmonth.removeClass("valid").addClass("invalid");
			}
			if(is_birthyear){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_haddress1").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_haddress = (value.length > 0 && re.test(value));
			if(is_haddress){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_haddress2").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_haddress2 = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_haddress2){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_hcity").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.cityState[cc];
		    var is_hcity = (value.length > 0 && re.test(value));
			if(is_hcity){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		$("#personal_hstate").change( function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.cityState[cc];
		    var is_hstate = (value.length > 0 && re.test(value));
			if(is_hstate){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_hzip").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = zipRegex.zip[cc];
		    var is_hzip = value.length > 4 && re.test(value);
		  	if (is_hzip) {			  	
		     input.val(value.replace(re, "$1"));
		    }
			if(is_hzip){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});

		$("#personal_submit button").click(function(event){	
		
			dateValidation();
			var form_data=$("#personal").serializeArray();
			var response = grecaptcha.getResponse();

			if (response.length == 0) { 
          		$("#recaptcha-error").show();
       		 }else {
          		$("#recaptcha-error").hide();
          		$("#personal_recaptchahide").addClass("valid");
          		
          		$("#personal_recaptchahide").blur(function() {
	
	        		$("#personal_recaptchahide").val("recaptch");
	
	    		});          
 			}
 			
 				var error_free=true;

 				
				for (var input in form_data){
					var element=$("#personal_"+form_data[input]["name"]);
					var feildName= form_data[input]["name"];
					var valid=element.hasClass("valid");
					var error_element="";
					if (feildName=="ssn" || feildName=="txtssn" || feildName=="haddress1"||feildName=="mnumber" ||feildName=="pnumber" || feildName=="email" ){
						error_element=$("span", element.parent().parent().parent());
					}else{
						error_element=$("span", element.parent().parent());
					}
					if (feildName=="appname" ||feildName=="transactionid" || feildName=="referencecode"){
						valid=true;
					}

					if(feildName=="pnumber" && $(element).val()==""){
						if ($("#personal_mtype").is(":checked") || $("#personal_ptype").is(":checked") ){
							valid =false;
						}
					}
					if (!valid){
						if(form_data[input]["name"]!="g-recaptcha-response"){
							error_element.removeClass("error").addClass("error_show"); error_free=false;
						} else{
						    error_element.removeClass("error_show").addClass("error");
						}
					}
					else{
					  if (feildName=="appname"|| feildName=="transactionid" || feildName=="referencecode"){
					 }else{
					    error_element.removeClass("error_show").addClass("error");
					 }
					    
					}
				}
				if (!error_free){
					event.preventDefault();
				}
				else{
					document.personalinformation.action = "personalinformationConfirm.jsp";
				
					document.personalinformation.submit();
					disableNextButton("personal_submit", "Please Wait.."); 
					return true;

				}

		});	
		
	}
	
	function dateValidation() {
		var regex = /[1-2][0-9][0-9][0-9]|\./;
		var regexday = /[0-3][0-9]|\./;
		var regexmonth = /[0-1][0-9]|\./;
		var element_birthmonth=$("#personal_birthmonth");
		var element_birthday=$("#personal_birthday");
		var element_birthyear=$("#personal_birthyear");
		element_birthmonth.removeClass("invalid").addClass("valid");
		element_birthday.removeClass("invalid").addClass("valid");
		var bd = element_birthday.val();
		var bm = element_birthmonth.val();
		var by = element_birthyear.val();
		var is_birthyear = by.length > 3 && regex.test(by);
		var is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
		var is_birthmonth = bm.length >0 && bm < 13 && regexmonth.test(bm);

		//alert(is_birthday + " First:"+bd);

		if(bm.length==1){
			bm = "0"+bm;
			element_birthmonth.val(bm);
			element_birthmonth.addClass("valid");
			is_birthmonth= true;
		}
		if(bd.length==1){
			bd = "0"+bd;
			element_birthday.val(bd);
			element_birthday.addClass("valid");	
			is_birthday=true;
		}
		if(bd=='00'){
			is_birthday = false;
		}
		if(bm == '00'){
			is_birthmonth = false;
		}
      // Ramesh: 10/29/2018- FICAM-588 Comment day and month validation check before validating year
	  // if(is_birthday && is_birthmonth){
			if(is_birthyear){
				if(is_birthyear){
				    var today = new Date();
				    //alert(value+"-"+bm+"-"+bd)
				    var birthDate = new Date(by+"-"+bm+"-"+bd);
				    //alert(value+"-"+bm+"-"+bd)
	
	
				    var age = today.getFullYear() - birthDate.getFullYear();
				    //alert(age)
				    //alert(" birthDate : " + birthDate.getUTCDate() + " today : " + today.getUTCDate());
				    if (birthDate.getUTCDate() < today.getUTCDate()){
				    	//alert(" today Month : " + today.getMonth() + " birthDate Month : " + birthDate.getMonth());
	
					    if (today.getMonth()-1 < birthDate.getMonth()){
					    	 age--;
					    	 //alert("if if date : "+ age)
					    }
				    }else{
				    	//alert(" today Month : " + today.getMonth() + " birthDate Month : " + birthDate.getMonth());
	
					    if (today.getMonth() < birthDate.getMonth()){
					    	 age--;
					    	 //alert("if month : "+ age)
					    }
				    }
				    var age = today.getFullYear() - birthDate.getFullYear();
				    //alert(age);
				    var min = 5;
				    if (age > min+1) {
				    	is_birthyear = true;
				    }else{
				    	is_birthyear = false;
				    }
				}
				if(bd.length >0){
	
					//alert(value)
					if(bm == '02'){
						if(by.length >0){
							if(!(by % 4) && (by % 100) || !(by % 400)){
								//alert("it is leap year : " + by);
								is_birthday = bd.length >0 && bd < 30 && regexday.test(bd);
							}else{
								//alert("it is not leap year : " + by);
								is_birthday = bd.length >0 && bd < 29 && regexday.test(bd);
							}
						}
						//alert("if it is 02 : " + is_birthmonth);
					}
					else if(bm == '00'){
						is_birthmonth = false;
					}else if(bm == '04' || bm == '06' || bm == '09' || bm == '11'){
						is_birthday = bd.length >0 && bd < 31 && regexday.test(bd);
						//alert("if it is 04 : " + is_birthmonth);
					}else{
						if(bd=='00'){
							is_birthday = false;
						}else{
							is_birthday = bd.length >0 && bd < 32 && regexday.test(bd);
						}
					}
				}
	
			}
		//}
		if(!is_birthday){
			//alert(is_birthday + bd);
			element_birthday.removeClass("valid").addClass("invalid");
		}
		if(!is_birthmonth){
			//alert(is_birthmonth + bm);

			element_birthmonth.removeClass("valid").addClass("invalid");
		}
		if(is_birthyear){element_birthyear.removeClass("invalid").addClass("valid");}
		else{element_birthyear.removeClass("valid").addClass("invalid");}
	};
	
	function personalConfPage(){
		$("#myBar").width("20%");
		$("#personal_continue button").click(function(event){	
				event.preventDefault(); //prevent default action 
				var decryptssnvalue = $.trim($("#personal_ssn").val());	 
				var ssnvalue =atob(decryptssnvalue);
							
				if (ssnvalue.length == 0) {  
					document.confirompersonal.action = "personalinformationlicense.jsp";					
					document.confirompersonal.submit();
					disableNextButton("personal_continue", "Please Wait..");
				}else{
					disableNextButton("personal_continue", "Please Wait..");
					var post_url = "identityProofingvalidation.jsp"; 
					var request_method = "POST";
					var form_data = $("form").serialize(); //Encode form elements  
					    form_data = form_data + '&ssn=' + ssnvalue;
						$.ajax({
    					url : post_url,
    					type: request_method,
    					data : form_data
					}).done(function(response){
				    	var trimmed = response.trim();				
						var passval = trimmed.substring(0, 6);
    					if(passval=="PASSED"){ 
    						var i = response.trim().indexOf(':');
    						var lexid = response.trim().substring(i+1); 
    						$("#personal_lexid").val(lexid);
    				 		document.confirompersonal.action = "showphoneInformation.jsp";					
							document.confirompersonal.submit();
							disableNextButton("personal_continue", "Please Wait..");
    					}else{
    						$("#messageid").append(response.trim()); 
    						$( "#response" ).show();
							disableNextButton("personal_continue", "");
    		                $('html, body').animate({
    		                    scrollTop: $("#messageid").offset().top
    		                }, 10);
    					}
					});
				}			

		});	
		$("#personal_edit button").click(function(event){				
			document.confirompersonal.action = "personalinformation.jsp";				
			document.confirompersonal.submit();
			disableNextButton("personal_edit", "Please Wait..");
			disableNextButton("personal_continue");
			return true;
			
		});	
	}
	
	function showPhoneinfo(){
		$("#myBar").width("40%");
		var count=0;
		if($("#personal_hnumber").val()!=""){
			$("#personal_hnumber").addClass("valid");
		}
	
		$("#personal_hnumber").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = phoneRegex.phone[cc];
		    var is_hnumber = value.length > 9 && re.test(value);
		  	if (is_hnumber) {
		     input.val(value.replace(re, "($1) $2-$3"));
		    }
			if(is_hnumber){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});

		$("#personal_submit button").click(function(event){	
			event.preventDefault(); //prevent default action 			
			var form_data=$("#personal").serializeArray();
				var error_free=true;
 			
			for (var input in form_data){
				var feildName= form_data[input]["name"];
				if(feildName=="hnumber"){
					var element=$("#personal_"+form_data[input]["name"]);
					var valid=element.hasClass("valid");
					var error_element=$("span", element.parent().parent().parent().parent());
					if (!valid){
						error_element.removeClass("error").addClass("error_show"); 
						error_free=false;						
					}else{
						//error_element.removeClass("error_show").addClass("error");
					}
				}
			}
			
			if (!error_free){
				event.preventDefault();
			} else {
				disableNextButton("personal_submit", "Please Wait.."); 
				var post_url = "phonevalidation.jsp"; 
				var request_method = "POST";
				var form_data = $("form").serialize(); //Encode form elements 
				$.ajax({
					url : post_url,
					type: request_method,
					data : form_data
				}).done(function(response){
			    	var trimmed = response.trim();	
					var passval = trimmed.substring(0, 6);
					if(passval=="PASSED"){ 
						document.personalinformation.action = "otpinformation.jsp";					
						document.personalinformation.submit();
						
					}else{
						count++;
        				if(count > 2){
        					//window.location.replace("/register/phoneFinalvalidationerror.jsp");
        					document.personalinformation.action = "phoneFinalvalidationerror.jsp";					
    						document.personalinformation.submit();
        				} 
						enableNextButton("personal_submit", "Next >");
						$("#messageid").empty();
						$("#messageid").append("<p>We are having trouble validating your phone number, please check your information, and enter it as it appears on your phone statement.  Three attempts are allowed to validate, this is attempt " + count +".</p>"); 
						$( "#response" ).show();
		                $('html, body').animate({
		                    scrollTop: $("#messageid").offset().top
		                }, 10);
					}
				});

			}

		});	
	}
	
	function qaPage(){
		$("#myBar").width("60%");
		var count = 0;	
		$("#quiz_submit button").click(function(event){			
			event.preventDefault();
			var dataString = "";				
			var form_data=$("#quiz").serializeArray();
			var length = form_data.length;
			var error_free=true;
			for (var input in form_data){
				var element=$("#quiz_"+form_data[input]["name"]);
				var feildName= form_data[input]["name"];

				dataString = dataString+form_data[input]["name"]+"="+element.val();
				
				length --;
				if (length > 0){
					dataString = dataString+"&";
				}
				if(element.val()!="CC")
				{element.removeClass("invalid").addClass("valid");}
				else{element.removeClass("valid").addClass("invalid");}
				
				var valid=element.hasClass("valid");
				var error_element=$("span", element.parent().parent());
				if (feildName!="fname" && feildName!="mname" && feildName!="lname" && feildName!="suffix" && feildName!="pnumber" && feildName!="mnumber" && 
						feildName!="email" && feildName!="transactionid" && feildName!="appname" && feildName!="ssn" && feildName!="birthmonth" && 
						feildName!="birthday" && feildName!="birthyear" && feildName!="haddress1" && feildName!="haddress2" && feildName!="hcity" && 
						feildName!="hstate" && feildName!="hzip" && feildName!="referencecode" && feildName!="lexid" &&
					    feildName!="licensestate" && feildName!="license" ){ 	
				if (!valid){
						error_element.removeClass("error").addClass("error_show"); 
						error_free=false;
				}
				else{
						error_element.removeClass("error_show").addClass("error");
					}
				}
			}
			if (!error_free){				
				event.preventDefault();
			}
			else{
				disableNextButton("quiz_submit", "Please Wait..page loading");
				 $.ajax({
        			type: "POST",
        			url: "qaresult.jsp",
        			data: dataString,
        			success: function (data) {
        				if(data.trim() != "PASS"){
            				count++;
            				if(count > 2){
            					window.location.replace("/register/quizerrorpage.jsp");
            				} 
            				$( "#response").hide();
            				$("#resultfromlexis").remove();
            				event.preventDefault();
            				$.ajax({
        						type: "POST",
        						url: "getqafromlexis.jsp",
        						data: dataString,
        						success: function (data) {
        							$( "#response" ).show();
									$("#addresult").append(data.trim()); 
									enableNextButton("quiz_submit", "Next >");
        						}
        					});
            				
            			}else{                			
            			
            				//window.location.replace("/register/companyinformation.jsp");
            				document.quizvalidatetion.action = "companyinformation.jsp";					
							document.quizvalidatetion.submit();
							disableNextButton("quiz_submit", "Please Wait..");
            			}               			
        			}
    			});
				return true;
			}
			
		});
	}
	
	function optInfo(){
		$("#myBar").width("50%");
		var element_mname=$("#personal_sessionid");
		element_mname.addClass("valid");
		var count = 0;	
		$("#personal_otp").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var re =/^1?(\d{5})$/;
		    var is_fivedigits = value.length > 4 && re.test(value);
		  	if (is_fivedigits) {			  	
		     input.val(value.replace(re, "$1"));
		    }
			if(is_fivedigits){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_submit button").click(function(event){			
			var form_data=$("#personal").serializeArray();
			var error_free=true;
			for (var input in form_data){
			var feildName= form_data[input]["name"];
			if(feildName=="otp"){
					var element=$("#personal_"+form_data[input]["name"]);
					
					var input=element;
					var value = $.trim(input.val()).replace(/\D/g, "");
					var re =/^1?(\d{5})$/;
				    var is_fivedigits = value.length > 4 && re.test(value);
				  	if (is_fivedigits) {			  	
				     input.val(value.replace(re, "$1"));
				    }
					if(is_fivedigits){input.removeClass("invalid").addClass("valid");}
					else{input.removeClass("valid").addClass("invalid");}
					
					var valid=element.hasClass("valid");
					var error_element=$("span", element.parent().parent());
					if (!valid){
						error_element.removeClass("error").addClass("error_show"); error_free=false;
					}
					else{
						error_element.removeClass("error_show").addClass("error");
					}
				}
			}
			if (!error_free){
				event.preventDefault();
			}
			else{
			
				event.preventDefault(); //prevent default action 
				var post_url = "verfiyopt.jsp"; 
				var request_method = "POST";
				var form_data = $("form").serialize(); //Encode form elements   
								
					$.ajax({
    				url : post_url,
    				type: request_method,
    				data : form_data
				}).done(function(response){
				    if(response.trim()=="false"){
				    	    count++;
            				if(count > 2){
            					document.personalinformation.action = "otpvalidationerror.jsp";					
								document.personalinformation.submit();
								disableNextButton("personal_submit", "Please Wait..");  
            				} 
            				$("#initmessage").hide();
            				$("#personal_otp").val("");
            				$("#messageid").empty();
    						$("#messageid").append("<p>The One Time Password validation has failed.  Please check your message, and re-enter the correct One Time Password. This is your " + count +" attempt, and you are allowed 3 attempts..</p>"); 
    						$( "#response" ).show();
				    }else{
				    	document.personalinformation.action = "lexisqapage.jsp";					
						document.personalinformation.submit();
						disableNextButton("personal_submit", "Please Wait,your unique identity validation quiz is loading");
				    }
				});
			}


		});
	}
	
	function companyPage(){
		$("#myBar").width("80%");
		
		var element_cname=$("#personal_cname");
		element_cname.addClass("valid");
		var element_title=$("#personal_title");
		element_title.addClass("valid");
		var element_cfax=$("#personal_cfax");
		element_cfax.addClass("valid");
		var element_caddress1=$("#personal_caddress1");
		element_caddress1.addClass("valid");
		var element_caddress2=$("#personal_caddress2");
		element_caddress2.addClass("valid");
		var element_ccity=$("#personal_ccity");
		element_ccity.addClass("valid");
		var element_cstate=$("#personal_cstate");
		element_cstate.addClass("valid");
		var element_czip=$("#personal_czip");
		element_czip.addClass("valid");
		
		$("#personal_cname").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_cname = ((value.length==0) || (value.length > 0 && re.test(value)));				
			if(is_cname){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_title").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_ctitle = ((value.length==0) || (value.length > 0 && re.test(value)));		
			if(is_ctitle){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});

		$("#personal_cfax").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = phoneRegex.phone[cc];
		    var is_cfax = ((value.length==0) || (value.length > 9 && re.test(value)));
		  	if (is_cfax) {
		     input.val(value.replace(re, "($1) $2-$3"));
		    }
			if(is_cfax){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_caddress1").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_caddress = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_caddress){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_caddress2").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.address[cc];
		    var is_caddress2 = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_caddress2){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_ccity").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.cityState[cc];
		    var is_ccity = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_ccity){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_cstate").change( function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.cityState[cc];
		    var is_cstate = ((value.length==0) || (value.length > 0 && re.test(value)));
			if(is_cstate){input.removeClass("invalid").addClass("valid");
			}else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_czip").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val()).replace(/\D/g, "");
			var cc="us";
			var re = zipRegex.zip[cc];
		    var is_czip = ((value.length==0) || (value.length > 4 && re.test(value)));
		  	if (is_czip) {			  	
		     input.val(value.replace(re, "$1"));
		    }
			if(is_czip){input.removeClass("invalid").addClass("valid");}
			else{input.removeClass("valid").addClass("invalid");}
		});
		
		$("#personal_submit button").click(function(event){
			var form_data=$("#personal").serializeArray();
			var error_free=true;
			for (var input in form_data){
				var feildName= form_data[input]["name"];
				var element=$("#personal_"+form_data[input]["name"]);
				var valid=element.hasClass("valid");
				var error_element=$("span", element.parent().parent());
	if((feildName!="fname") && (feildName!="mname")  &&  (feildName!="lname") && (feildName!="suffix") 
	&& (feildName!="email") && (feildName!="lexid") && (feildName!="pnumber") && (feildName!="mnumber")
	&& (feildName!="haddress1")&& (feildName!="haddress2")&& (feildName!="hcity")&& (feildName!="hstate")&& (feildName!="hzip")
		&& (feildName!="referencecode"))
		{							if (!valid){
						error_element.removeClass("error").addClass("error_show"); 
						error_free=false;						
					}else{
						error_element.removeClass("error_show").addClass("error");
					}
				}
			}
			if (!error_free){
				event.preventDefault();
			} else{
				document.personalinformation.action = "createUserInIDM.jsp";
				document.personalinformation.submit();
				disableNextButton("personal_submit", "Please Wait..");  
				return true;	
			}

		});	
	}
	
	function licensePage(){
		$("#myBar").width("20%");
		var count = 0;				

		{
			var element_cccount=$("#personal_cccount");
			element_cccount.addClass("valid");
			var element_fname=$("#personal_fname");
			element_fname.addClass("valid");
			var element_mname=$("#personal_mname");
			element_mname.addClass("valid");
			var element_lname=$("#personal_lname");
			element_lname.addClass("valid");
			var element_suffix=$("#personal_suffix");
			element_suffix.addClass("valid");
			var element_birthmonth=$("#personal_birthmonth");
			element_birthmonth.addClass("valid");
			var element_birthday=$("#personal_birthday");
			element_birthday.addClass("valid");
			var element_birthyear=$("#personal_birthyear");
			element_birthyear.addClass("valid");
			var element_mnumber=$("#personal_mnumber");
			element_mnumber.addClass("valid");
			var element_mnumber=$("#personal_pnumber");
			element_mnumber.addClass("valid");
			var element_haddress1=$("#personal_haddress1");
			element_haddress1.addClass("valid");
			var element_haddress2=$("#personal_haddress2");
			element_haddress2.addClass("valid");
			var element_hcity=$("#personal_hcity");
			element_hcity.addClass("valid");
			var element_hzip=$("#personal_hzip");
			element_hzip.addClass("valid");
			var element_hstate=$("#personal_hstate");
			element_hstate.addClass("valid");
			var element_ccn=$("#personal_ccn");
			element_ccn.addClass("valid");
			var element_ssn=$("#personal_ssn");
			element_ssn.addClass("valid");
			var element_email=$("#personal_email");
			element_email.addClass("valid");
			var element_mtype=$("#personal_mtype");
			element_mtype.addClass("valid");
			
			//var element_license=$("#personal_license");
			//element_license.addClass("invalid");
			//var element_licensestate=$("#personal_licensestate");
			//element_licensestate.addClass("invalid");
			
			var element_phonetype=$("#personal_phonetype");	
			element_phonetype.addClass("valid");
			var element_lexid=$("#personal_lexid");	
			element_lexid.addClass("valid");
			var element_otpsession=$("#personal_otpsession");
			element_otpsession.addClass("valid");
			var element_appname=$("#personal_appname");
			element_appname.addClass("valid");
			var element_transactionid=$("#personal_transactionid");
			element_transactionid.addClass("valid");
			var element_referencecode=$("#personal_referencecode");
			element_referencecode.addClass("valid");
		}
	    $("#personal_chkShow").change(function() {
	
	        var isChecked = $(this).prop("checked");
		
	        if (isChecked) {
				$("#personal_nostate").css("display", "inline");
				$("#personal_nossn").css("display", "none");
				$("#response").css("display", "none");
				$("#personal_licensestate").val('');
				$("#personal_license").val('');
				var element_license=$("#personal_license");
				element_license.addClass("valid");
				var element_licensestate=$("#personal_licensestate");
				element_licensestate.addClass("valid");
	
	        } else {
				$("#personal_nossn").css("display", "inline");		
				$("#personal_nostate").css("display", "none");
				$("#response").css("display", "none");			
	        }
	
	    });

	   $("#personal_edit button").click(function(event){				
			document.personalinformation.action = "personalinformation.jsp";				
			document.personalinformation.submit();
			disableNextButton("personal_edit", "Please Wait..");
			disableNextButton("personal_continue");
			return true;
			
		});
		$("#personal_license").on("input", function() {
			var input=$(this);
			var value = $.trim(input.val());
			var cc="us";
			var re = validTextRegex.noSpace[cc];
		    var is_license = (value.length > 7 && re.test(value));			    
			if(is_license){				
				input.removeClass("invalid").addClass("valid");
			}
			else{input.removeClass("valid").addClass("invalid");}
		});

		
		$("#personal_licensestate").change( function() {
			var input=$(this);
			var is_hstate=input.val();
			if(is_hstate){				
				input.removeClass("invalid").addClass("valid");
			}
			else{input.removeClass("valid").addClass("invalid");}
		});

		$("#personal_continue button").click(function(event){			
			event.preventDefault();
			var isChecked = $("#personal_chkShow").prop("checked");			
		    if (isChecked) {
		        document.personalinformation.action = "personalinformation.jsp";
				document.personalinformation.submit();
				disableNextButton("personal_continue", "Please Wait..");
				return true;
		     }
			var form_data=$("#personal").serializeArray();
			var error_free=true;
			for (var input in form_data){
				var element=$("#personal_"+ form_data[input]["name"]);
				var feildName= form_data[input]["name"];
				var valid=element.hasClass("valid");
				var error_element=$("span", element.parent().parent());
				
				if (!valid){
					error_element.removeClass("error").addClass("error_show");
					error_free=false;
				}else{
					if((feildName=='licensestate')||(feildName=='license')){
						error_element.removeClass("error_show").addClass("error");
					}
				}
			}
			if (!error_free){
				event.preventDefault();	
			}
			else{
					disableNextButton("personal_continue", "Please Wait..");

					var post_url = "identityProofingvalidation.jsp"; 
					var request_method = "POST";
					var form_data = $("form").serialize(); //Encode form elements  
						$.ajax({
    					url : post_url,
    					type: request_method,
    					data : form_data
					}).done(function(response){
				    	var trimmed = response.trim();				
						var passval = trimmed.substring(0, 6);
    					if(passval=="PASSED"){ 
    						var i = response.trim().indexOf(':');
    						var lexid = response.trim().substring(i+1); 
    						$("#personal_lexid").val(lexid);
    				 		document.personalinformation.action = "showphoneInformation.jsp";					
							document.personalinformation.submit();
							disableNextButton("personal_continue", "Please Wait..");
    					}else{
    						var transactionid = uuidv4()+":"+$("#personal_appname").val();
    						$("#personal_transactionid").val(transactionid);
    						$("#messageid").empty();
    						count++;
    						$("#messageid").append(response.trim()); 
    						$( "#personal_nossn" ).hide();
    						$( "#response" ).show();
    						enableNextButton("personal_continue", "Next >");
            				if(count > 2){
								document.personalinformation.action = "personalinformation.jsp";				
								document.personalinformation.submit();
								disableNextButton("personal_edit", "Please Wait..");
								disableNextButton("personal_continue");
            				} 
    					}
					});

			}

		});	
	}
