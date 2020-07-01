function idCheck() {
	var joinid = $('#joinid').val();
	if(joinid.length < 4 || joinid.length > 20){
		$('#idmessage').html('ID는 4글자 이상 15글자 이하만 가능합니다.');
		$('#joinid').focus();
		return false;
	}else if (joinid.replace(/[a-z.0-9]/gi,'').length>0){
		$('#idmessage').html('ID는 영문자와 숫자로만 입력해주세요.');
		$('#joinid').focus();
		return false;
	}else{
		$('#idmessage').html('');
		return true;
	}
}; // idcheck

function pwCheck() {
	var joinpw=$('#joinpw').val();
	var passwordlength=('#joinpw').length;
	
	if(joinpw.length < 5 || joinpw.length > 20){
		$('#pwmessage').html('Password는 5글자 이상 입력해야합니다.');
		$('#joinpw').focus();
		return false;
	}else if(joinpw.replace(/[!-*]/gi, '').length >= passwordlength){
		$('#pwmessage').html('Password는 특수문자가 반드시 포함되어야 합니다.');
		$('#joinpw').focus();
		return false;
	}else if(joinpw.replace(/[0-9.!-*]/gi,'').length>0){
		$('#pwmessage').html('Password는 숫자와 특수문자로만 입력해주세요.');
		$('#joinpw').focus();
		return false;
	}else{
		$('#pwmessage').html('');
		return true;
	}
	
}; // pwCheck()

function nameCheck() {
	var namecheck=$('#joinname').val();
	var namelength = joinname.length;
	
	if(joinname.length < 2 || joinname.length > 5){
		$('#namemessage').html('이름은 2글자 이상 5글자 이하로 입력해주세요.');
		$('#joinname').focus();
		return false;
	}
	
}; // nameCheck()