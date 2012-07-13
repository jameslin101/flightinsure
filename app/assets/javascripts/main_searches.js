// jQuery(function() {
// 
//   $('.datepicker').datepicker();
// 
//   $('.remove_flight_search').click( function(event) {	
// 	if ($('fieldset').length > 1) {
//     	$(this).closest('fieldset').remove();
// 	}	
//     return event.preventDefault();
//   });
// 
//   $('.add_flight_search').click( function(event) {
//     var regexp, time;
//     time = new Date().getTime();
// 	$clone = $('fieldset:first').clone(true,true)
// 	$('fieldset:last').after($clone)
// 	$clone.datepicker();
// 
//     return event.preventDefault();
//   });
// })

jQuery(function() {
  $('form').on('click', '.remove_flight_search', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
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