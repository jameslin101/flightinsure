jQuery(function() {
    
  // var locateX = function() {
  //   var wellPos = $(this).closest('.well').position()
  //   var wellWidth = $(this).closest('.well').outerWidth()
  //   alert($(this).position())
  //   $(this).css({
  //       position: "relative",
  //       top: wellPos.top + "px",
  //       left: (wellPos.left + wellWidth) + "px"
  //   }).show();
  // }
  // 
  // $(".remove_flight_search").each(locateX());
  
  //bootstap typeahead
  $('.dropdown-toggle').dropdown()
  
  $('form').on('click', '.remove_flight_search', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.well').hide();
    return event.preventDefault();
  });
  $('form').on('click', '.add_flight_search', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
	
    return event.preventDefault();
  });

	$(function() {
      $( ".datepicker" ).datepicker();
      return event.preventDefault();
  });
});