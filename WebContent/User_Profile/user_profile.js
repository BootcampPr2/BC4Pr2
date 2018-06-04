$(document).ready(function(){
	$('input[type=password]').keyup(function() {
		var pswd = $(this).val();
		
		//validate the length
		if ( pswd.length < 8 ) {
			$('#length').removeClass('valid').addClass('invalid');
		} else {
			$('#length').removeClass('invalid').addClass('valid');
		}
		
		//validate lowercase letter
		if ( pswd.match(/[a-z]/) ) {
			$('#letter').removeClass('invalid').addClass('valid');
		} else {
			$('#letter').removeClass('valid').addClass('invalid');
		}

		//validate capital letter
		if ( pswd.match(/[A-Z]/) ) {
			$('#capital').removeClass('invalid').addClass('valid');
		} else {
			$('#capital').removeClass('valid').addClass('invalid');
		}

		//validate number
		if ( pswd.match(/\d/) ) {
			$('#number').removeClass('invalid').addClass('valid');
		} else {
			$('#number').removeClass('valid').addClass('invalid');
		}
		
		//validate space
		if ( pswd.match(/[^a-zA-Z0-9\-\/]/) ) {
			$('#space').removeClass('invalid').addClass('valid');
		} else {
			$('#space').removeClass('valid').addClass('invalid');
		}
		
	});
	
	var clas = $("#classification").val();
	if (clas == "Underweight"){				
		$('#underweight').addClass('category');
	}else if (clas == "Optimal"){
		$('#optimal').addClass('category');
	}else if (clas == "Overweight"){
		$('#overweight').addClass('category');
	}else{
		$('#obese').addClass('category');
	}
	
	$("#checkAll").click(function() {
		$(".tickbox").prop('checked',$(this).prop('checked'));
	});
});

$(function() {
	$('#profile-image1').on('click', function() {
		$('#profile-image-upload').click();
	});
});
          