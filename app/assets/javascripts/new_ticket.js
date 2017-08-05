$(window).load(function() {
  $('.js-journey-select').change(function() {
  	  // return console.log($(this).val());
  	$.ajax('/journey/' + $(this).val() + '/journey_selection')
		.then(
		    function success(data) {
		    	// return console.log($(this).val()
		        $('.js-journey-station-select').empty();
	            $('.js-journey-station-select').append($('<option>').text("Select Station").attr('value', ''));
	            $.each(data, function(i, obj){
	                    $('.js-journey-station-select').append($('<option>').text(obj.name).attr('value', obj.id));
	            });
		    },

		    function fail(data, status) {
		        alert('Error: ' + status);
		    }
		);

  });

  $('.js-journey-select').change();
});


$(window).load(function() {
	$('.js-journey-station-select').change(function() {
		var startStationId = $('#start-station').val();
		var finalStationId = $('#final-station').val();
		var journeyId = $( ".js-journey-select option:selected" ).val()

		// console.log(startStationId)
		// console.log(finalStationId)
  	    if ((startStationId && finalStationId) != '' ) {
  	    	
  	    	
			 // console.log(journeyId);
			$.ajax({
			  url: ('/journey/' + journeyId + '/journey_info'),
			  type: "GET", 
			  data: {
			    startStationId: startStationId, 
			    finalStationId: finalStationId
			  },
			  success: function(data) {
					var ticketPriceHtml;
					if(data.price == -1){
					ticketPriceHtml = "Can't calculate ticket for chosen stations. Please try to select other station. If have any question contact support"
					} else {
					ticketPriceHtml = "Price: " + data.price + " UAH";
					}
					$('#ticket_price').html(ticketPriceHtml)
			 
	
			  },
			  error: function(data, status) {
			    alert('Error: ' + status);
			  }
			});
		}
		 	

    });
});
