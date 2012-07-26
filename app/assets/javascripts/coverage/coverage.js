jQuery(function() {
	$.ajaxSetup( { "async": false } );
		
	var initPremium = function(current_node) {
		//current_node = this;
	
		p = $(current_node).children().filter(":selected").val();
		n = $.post("/getpayouts");
	
		d = {"premium":p}
		$.getJSON('/getpayouts.json', d, function(data) {
		  var items = [];
	
		  $.each(data, function(key, val) {
			var node = $(current_node.parentNode.parentNode).children().find("."+key)
			
			node.text("$" + val);
			node.data("val",val);
			
		  });
	
		});
	    //return e.preventDefault();
	    
	}
	//$('.premium').each(alert("hey"))

	var calcTotalPremium = function() {

		var total = 0;
		$('.premium').each (function () {
			if ($(this.parentNode.parentNode).children().find(".coverage_select").is(':checked')) {
				var currency = $(this).val();
				var number = Number(currency.replace(/[^0-9\.]+/g,""));
				total += number;
			}
		});
	  return "$"+total;

	}

	var calcTotalCoverage = function() {

		var total = 0;
		$('.c4').each (function () {
		  if ($(this.parentNode.parentNode).children().find(".coverage_select").is(':checked')) {			
  			var currency = $(this).data("val")
  			total += currency;
			}
		});
	  return "$"+total;

	}

	$('.premium').on('change', function(event) {
		current_node = this;

		initPremium(this);
		$('#total_premium').text(calcTotalPremium);
		$('#total_coverage').text(calcTotalCoverage);

	   return event.preventDefault();
	});


	$('.coverage_select').on('change', function(event) {
		$('#total_premium').text(calcTotalPremium);
		$('#total_coverage').text(calcTotalCoverage);
    checked_val = this.checked
    //alert("this is "+checked_val)
    set_destroy = 0;
    if (checked_val == false)  
      {set_destroy = 1;}
    else 
      {set_destroy = 0;}
    
    $(this).parent().children().children().val(set_destroy);
    //alert ($(this).parent().children().children().val())  
	  return event.preventDefault();
	});

  //Execute on load

	$('.premium').each(function(index) {
	   initPremium(this);
	});
	
	$('#total_premium').text(calcTotalPremium);
	$('#total_coverage').text(calcTotalCoverage);
	
});
	