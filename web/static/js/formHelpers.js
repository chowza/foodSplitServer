export function addUserChatGroup(){
	
	var index = $('.userChatGroup').length

	$('.form-group input[type="submit"]').parent().before(
		`<div class="form-group">
	      <label class="control-label userChatGroup" for="chat_group_userChatGroups_${index}_user_id">User Id</label>
	      <input class="form-control" id="chat_group_userChatGroups_${index}_user_id" name="chat_group[userChatGroups][${index}][user_id]" type="number">
	    </div>`
    )
}