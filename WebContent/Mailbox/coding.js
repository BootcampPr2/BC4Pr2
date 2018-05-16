$('document').ready(() => {
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
});

$('#NM').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-compose').show();   
});

$('#IM').on('click',() => {
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-incoming').show();
});

$('#SM').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-sent').show();                      		
});

$('.unread').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-readInboxMessage').show();
	
});

$('.readInb').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-readInboxMessage').show();
});

$('.readSent').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').show();
});

function openMessage(myUser,myMessage,myDate) {
	$('#fromView').val(myUser);
	$('#messageView').val(myMessage);
	$('#dateView').val(myDate);
	
}

