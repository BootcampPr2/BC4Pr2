$('document').ready(function(){
	getIncoming();
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.filtered-messages').hide();
	

	$('#NM').click(function(){
		$('.inbox-body.inbox-incoming').hide();
		$('.inbox-body.inbox-sent').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.filtered-messages').hide();
		$('.inbox-body.inbox-compose').show();   
	});

	$('#IM').click(function(){
		$('.inbox-body.inbox-sent').hide();
		$('.inbox-body.inbox-compose').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.filtered-messages').hide();
		$('.inbox-body.inbox-incoming').show();
	});

	$('#SM').click(function(){
		$('.inbox-body.inbox-incoming').hide();
		$('.inbox-body.inbox-compose').hide();
		$('.inbox-body.inbox-readInboxMessage').hide();
		$('.inbox-body.inbox-readSentMessage').hide();
		$('.inbox-body.filtered-messages').hide();
		$('.inbox-body.inbox-sent').show();                      		
	});
	
	$('[data-toggle="tooltip"]').tooltip(); 
	
	$("#checkAll").click(function() {
		$(".mail-checkbox.mail-inbox").prop('checked',$(this).prop('checked'));
	});

	$("#checkAll_Sent").click(function() {
		$(".mail-checkbox.mail-sent").prop('checked',$(this).prop('checked'));
	});

	$("#checkAllFiltered").click(function() {
		$(".mail-checkbox.mail-filtered").prop('checked',$(this).prop('checked'));
	});

});

function openInboxMessage(myUser,myMessage,myDate,id,isRead) {
	$('#fromView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView').val(myMessage);	
	$('#dateView').val(myDate);
	$('#inid').val(id);

	if (isRead == 0){
		var counter = parseInt($('#counter').text()) - 1;
		$('#counter').text(counter);
	}		

	// set message as read
	var dataToBeSent  = {
			messageID : id
	};
	$.ajax({
		url : 'ajax-setread.jsp',
		data : dataToBeSent, 
		type : 'POST',
	});
	
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.filtered-messages').hide();
	$('.inbox-body.inbox-readInboxMessage').show();

}

function openSentMessage(myUser,myMessage,myDate,id) {
	$('#toView').val(myUser);
	myMessage = myMessage.replace(/<br\s*\/?>/mg,"\n");
	$('#messageView1').val(myMessage);
	$('#dateView1').val(myDate);
	$('#senid').val(id);
	
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();    
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.filtered-messages').hide();
	$('.inbox-body.inbox-readSentMessage').show();
};

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

	updateCounter();
}

function getFiltered(){
	$.ajax({
		url: "ajax-searchmail.jsp",
		data:{filterTerm: $('#search').val()},
		success: 
			function(result){
			$("#filteredByUser").html(result);
		}
	}
	);
	
	updateCounter();
	showFiltered()
	
}


function deleteSelectedMessages(caller){
	var allChecked = [];

	if (caller.name == "deleteReceived"){
		$('input[name=CI]').each(function(){
			if($(this).prop('checked')){
				allChecked.push($(this).val())
			}
		})
	}else if(caller.name == "deleteFiltered"){
		$('input[name=CF]').each(function(){
			if($(this).prop('checked')){
				allChecked.push($(this).val())
			}
		})
	}else{
		$('input[name=CS]').each(function(){
			if($(this).prop('checked')){
				allChecked.push($(this).val())
			}
		})
	}
	
	ajaxDeleteMessages(allChecked, caller.name);

}

function deleteOpenedMessage(caller){
	var deletedMessage;
	if (caller.name == "deleteIncomingMessage")
		deletedMessage = $('#inid').val();
	else
		deletedMessage = $('#senid').val();
	
	ajaxDeleteMessages(deletedMessage,caller.name);

	
}

function ajaxDeleteMessages(allChecked, caller){
	$.ajax({
		url : 'ajax-deletemessages.jsp',
		data :{ 
			checked: JSON.stringify(allChecked)
		},
		type : 'POST',
		success:
			function(){
			refreshMailbox(caller);
		}
	});
}

function updateCounter(){
	$.ajax({
		url: "ajax-getcounter.jsp",
		success: 
			function(result){
			$("#counter").html(result);
		}
	}
	);
}

function refreshMailbox(caller){
	console.log(caller);
	if ((caller == "deleteReceived") || (caller == "deleteIncomingMessage")){
		getIncoming();
		showIncoming();
	}
	else if ((caller == "deleteSent") || (caller == "deleteSentMessage")) {
		getSent();
		showSent();
		updateCounter()
	}else{
		updateCounter();
		getFiltered();
		showFiltered();
	}
}

function showIncoming(){
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.filtered-messages').hide();
	$('.inbox-body.inbox-compose').hide();   
	$('.inbox-body.inbox-incoming').show();
}

function showSent(){
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.filtered-messages').hide();
	$('.inbox-body.inbox-compose').hide();  
	$('.inbox-body.inbox-sent').show();
}

function showFiltered(){
	$('.inbox-body.inbox-incoming').hide();
	$('.inbox-body.inbox-sent').hide();
	$('.inbox-body.inbox-readInboxMessage').hide();
	$('.inbox-body.inbox-readSentMessage').hide();
	$('.inbox-body.inbox-compose').hide();
	$('.inbox-body.filtered-messages').show();
}
