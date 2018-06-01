//var tds = document.getElementsByTagName('td');
//var column = [];
//for (var i=0; i<tds.length; i++) {
//if (tds[i].innerHTML.match("Admin")) {
//tds[i].innerHTML.bgcolor = "Yellow";
//}
//}

//function toggle(source) {
//	checkboxes = document.getElementsByName('foo');
//	for (var i = 0, n = checkboxes.length; i < n; i++) {
//		checkboxes[i].checked = source.checked;
//	}
//}

$("#checkAll").click(function() {
	$(".selectMessages").prop('checked',$(this).prop('checked'));
});