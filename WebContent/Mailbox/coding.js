$('document').ready(() => {
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
});

$('#NM').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').show();   
});

$('#IM').on('click',() => {
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-incoming').show();
});

$('#SM').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-sent').show();                      		
});

