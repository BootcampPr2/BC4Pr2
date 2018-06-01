$('document').ready(function(){
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	getIncoming();
	
	$('#NM').click(function(){
		$('.inbox-body.inbox-incoming').hide();
		$('.inbox-body.inbox-sent').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.inbox-compose').show();   
	});

	$('#IM').click(function(){
		$('.inbox-body.inbox-sent').hide();
		$('.inbox-body.inbox-compose').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.inbox-incoming').show();
	});

	$('#SM').click(function(){
		$('.inbox-body.inbox-incoming').hide();
		$('.inbox-body.inbox-compose').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.inbox-sent').show();                      		
	});
	
	$('.sr-input').click(function(){
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

});

/*$('.view-message').click(function(){
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-readInboxMessage').show();
	console.log("kati");
});*/

/*$('.view-message.1').click(function(){
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').show();
	$('.inbox-body.inbox-readInboxMessage').hide();

});*/

function openInboxMessage(myUser,myMessage,myDate,id,isRead) {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-readInboxMessage').show();
	
	$('#fromView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView').val(myMessage);
	$('#dateView').val(myDate);
	$('#inid').val(id);
	/*$('#' + id).removeClass("unread");
	$('#' + id).addClass("readInb");
	*/
	
	if (isRead == 0){
		var counter = parseInt($('#counter').text()) - 1;
		$('#counter').text(counter);
	}		
	
	// set message as read
	var dataToBeSent  = {
			messageID : id
	};
	$.ajax({
		url : 'setread.jsp',
		data : dataToBeSent, 
		type : 'POST',
	});
}

function getSent(){
	$.ajax({
		url: "ajax-getsent.jsp",
		success: 
				function(result){
					$("#sentMessages").html(result);
				}
			}
	);
}

function getIncoming(){
	$.ajax({
		url: "ajax-getincoming.jsp",
		success: 
				function(result){
					$("#incomingMessages").html(result);
				}
			}
	);
	
	$.ajax({
		url: "ajax-getcounter.jsp",
		success: 
				function(result){
					$("#counter").html(result);
				}
			}
	);
}

function openSentMessage(myUser,myMessage,myDate,id) {
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').show();
	$('.inbox-body.inbox-readInboxMessage').hide();
	
	$('#toView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView1').val(myMessage);
	$('#dateView1').val(myDate);
	$('#senid').val(id);
};

