$( document ).on( "pagecreate", function() {
	// Decrease width and height by 30 to tolerate 15 pixels at each side
    function scale( width, height, padding, border ) {
        var scrWidth = $( window ).width() - 30,
            scrHeight = $( window ).height() - 30,
            ifrPadding = 2 * padding,
            ifrBorder = 2 * border,
            ifrWidth = width + ifrPadding + ifrBorder,
            ifrHeight = height + ifrPadding + ifrBorder, 
            h, 
            w;
        if ( ifrWidth < scrWidth && ifrHeight < scrHeight ) {
            w = ifrWidth;
            h = ifrHeight;
        } else if ( ( ifrWidth / scrWidth ) > ( ifrHeight / scrHeight ) ) {
            w = scrWidth;
            h = ( scrWidth / ifrWidth ) * ifrHeight;
        } else {
            h = scrHeight;
            w = ( scrHeight / ifrHeight ) * ifrWidth;
        }
        return {
            'width': w - ( ifrPadding + ifrBorder ),
            'height': h - ( ifrPadding + ifrBorder )
        };
    };
    $(".ui-popup iframe").attr( "width", 0 ).attr( "height", "auto" );
    $("#popupVideo1, #popupVideo2, #popupVideo3, #popupVideo4, #popupVideo5").on({
        popupbeforeposition: actBeforePosition,
        popupafterclose: actAfterClose
    });
    function actBeforePosition() {
        var size = scale(640, 360, 15, 1 ),
   			w = size.width,
            h = size.height;
        $("#" + $(this).attr('id') + " iframe").attr( "width", w ).attr( "height", h );
	}				
	function actAfterClose() {
        $("#" + $(this).attr('id') + " iframe").attr( "width", 0 ).attr( "height", 0 );
	}
	
});

function controlVideo() {
	document.getElementById("popupVideo1").focus();
}
