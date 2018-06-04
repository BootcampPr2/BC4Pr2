$(document).ready(function(){
	$("#checkAll").click(function() {
		$(".selectMessages").prop('checked',$(this).prop('checked'));
	});
});