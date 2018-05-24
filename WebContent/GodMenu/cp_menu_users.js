$(document).ready(function(){

	
});

$("#checkAll").click(function() {
	$(".selectMessages").prop('checked',$(this).prop('checked'));
});

function visibilityCheck(roleName){
	console.log(roleName);
	if (roleName == "ADMIN"){
		$("#onlyGod").style.display = "none";
	}
}