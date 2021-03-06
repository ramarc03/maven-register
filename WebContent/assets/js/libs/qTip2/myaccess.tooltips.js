// prevent smaller screens from attaching.running
if(!navigator.userAgent.match(/iPhone/i) && !navigator.userAgent.match(/Android/i)){
$(function () {
	//Password Help
	$('#passwordHelp').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			title: {
				text: "Password Help",
				button: "close"
			},
			ajax: {
				url: "passwordHelp.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "left center",
			at: "right center",
			target: $('#password'),
			adjust: {
				x: 5
			}
		},
		show: {
			event: "click"
		},
		hide: {
			event: false
		},
		style: {
			classes: "ui-tooltip-cream ui-tooltip-rounded ui-tooltip-shadow",
			tip: {
				corner: true,
				height: 12
			}
		}
	});
	//What Is MyAccess
	$('#whatIs').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			ajax: {
				url: "whatIs.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "top right",
			at: "bottom center",
			target: $('#whatIs'),
			adjust: {
				y: 2
			}
		},
		show: {
			event: "mouseover"
		},
		hide: {
			delay: 500,
			fixed: true
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
	//Terms Modal
	$('#tou').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			title: {
				text: "MyAccess Ganga Applications Terms of Use",
				button: "close"
			},
			ajax: {
				url: "tou.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "center",
			at: "center",
			target: $(document)
		},
		show: {
			event: "click",
			modal: true
		},
		style: {
			classes: "ui-tooltip-light ui-tooltip-rounded ui-tooltip-shadow login_help"
		}
	});
	
	//Why need this
	$('#whyneed').click(function(e){e.preventDefault();}).qtip({
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
			event: "mouseover"
		},
		hide: {
			delay: 500,
			fixed: true
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
	// Help Desk Information
	$('.helpDesk').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			ajax: {
				url: "help_desk_information.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "top right",
			at: "bottom right",
			target: $('.helpDesk'),
			adjust: {
				x: -20,
				y: 5
			}
		},
		show: {
			event: "mouseover"
		},
		hide: {
			delay: 500,
			fixed: true
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
			width: '400px'
				
		}
	});
	// Login Help Modal
	$('.loginHelp').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			title: {
				text: "Need Help Logging in?",
				button: "close"
			},
			ajax: {
				url: "login_help.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "center",
			at: "center",
			target: $(document)
		},
		show: {
			event: "click",
			modal: true
		}
		,
		style: {
			classes: "ui-tooltip-light ui-tooltip-rounded ui-tooltip-shadow" 
		},
		hide: { event: 'click' } 
	});
	
	//Privacy Disclaimer Modal
	$('#privacy1').click(function(e){e.preventDefault();}).qtip({
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
			my: "top left",
			at: "bottom left",
			target: $('#privacy1'),
			adjust: {
				x: -20,
				y: 5
			}
		},
		show: {
			event: "mouseover"
		},
		hide: {
			delay: 100,
			fixed: true
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
	
	//Privacy Disclaimer Modal 2
	$('#privacy2').click(function(e){e.preventDefault();}).qtip({
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
			event: "mouseover"
		},
		hide: {
			delay: 100,
			fixed: true
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
	
	//Privacy3 Disclaimer Modal 2 - companyinfo
	$('#privacy3').click(function(e){e.preventDefault();}).qtip({
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
			my: "top left",
			at: "bottom left",
			target: $('#privacy3'),
			adjust: {
				x: -20,
				y: 5
			}
		},
		show: {
			event: "mouseover"
		},
		hide: {
			delay: 100,
			fixed: true
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
	
	//States List
	$('#statesList').click(function(e){e.preventDefault();}).qtip({
		content: {
			text: "Loading&hellip;",
			ajax: {
				url: "statesList.html",
				dataType: 'html',
				loading: false,
				type: "GET"
			}
		},
		position: {
			my: "top left",
			at: "bottom left",
			target: $('#statesList'),
			adjust: {
				x: -20,
				y: 5
			}
		},
		show: {
			event: "mouseover"
		},
		hide: {
			delay: 100,
			fixed: true
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
			width: '500px'
				
		}
	});
});
} // close if