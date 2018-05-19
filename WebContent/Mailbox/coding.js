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

$('.view-message.1').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').show();
	$('.inbox-body.inbox-readInboxMessage').hide();

});

$('.sr-input').on('click',() => {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').show();
	$('.inbox-body.inbox-readInboxMessage').hide();

});

//function findUser(list){
//for (var i=0; i<list.length();i++){
//if (document.getElementById("search") == list(i)){

//}
//}
//}

function openInboxMessage(myUser,myMessage,myDate,id) {
	$('#fromView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView').val(myMessage);
	$('#dateView').val(myDate);
	$('#inid').val(id);
	$('#' + id).removeClass("unread");
	$('#' + id).addClass("readInb");
	var counter = parseInt($('#counter').text()) - 1;
	$('#counter').text(counter);
}

function openSentMessage(myUser,myMessage,myDate,id) {
	$('#toView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView1').val(myMessage);
	$('#dateView1').val(myDate);
	$('#senid').val(id);
}

function setRead() {
	var dataToBeSent  = {
			messageID : $(".openInboxMessage").attr('id')
	};
	console.log(dataToBeSent);
	$.ajax({
		url : 'setread.jsp',
		data : dataToBeSent, 
		type : 'POST',
	});
}
