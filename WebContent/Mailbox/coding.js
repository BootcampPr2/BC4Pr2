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

$('.view-message').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-readInboxMessage').show();
	
});

function openInboxMessage(myUser,myMessage,myDate) {
	$('#fromView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView').val(myMessage);
	$('#dateView').val(myDate);
	
}

function openSentMessage(myUser,myMessage,myDate) {
	$('#toView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView1').val(myMessage);
	$('#dateView1').val(myDate);
	
}