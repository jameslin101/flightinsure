jQuery(function() {
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

  $('form').on('hover', '.datepicker', function(event) {
 	$(this).datepicker();
    return event.preventDefault();

  });
	
});