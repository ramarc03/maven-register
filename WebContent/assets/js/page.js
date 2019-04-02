
function setfocus(id) {
  function setFocusOn($el) {
    if ( $el.length ) {
      var a0 = $el.get(0);
      if ( a0 ) {
        if (! $el.is(':input') ) {
          a0.setAttribute('role','alert');
          a0.setAttribute('tabIndex','-1');     
        }
        setTimeout(function() {
          a0.focus();
          }, 0);
        return true;
      }
    }
    return false;
  }
  function setErrorFocus() {
    var $errorContainer = $('#spNoMatch');
    if ( (! $errorContainer.length) || (! $errorContainer.is(':visible')) ) {
      return false;
    }
    if ($.trim($errorContainer.html())==='') {
      return false;
    }
    setFocusOn($errorContainer);
    return true;
  }
  if ( !setErrorFocus() ) {
    var $focus;
    if (typeof id === 'undefined') {
      $focus = $('#body h1:first');
    } else {
      $focus =  $('#'+id);
    }
    if ( ! setFocusOn($focus) ) {
      //HTML5 autofocus Fallback
      if (!('autofocus' in document.createElement('input'))) {
        $('[autofocus]:first').get(0).focus();
      }
    }
  }
} // setfocus()
