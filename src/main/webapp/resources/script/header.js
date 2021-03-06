$(function(){
	var id = $('#islogin').val();
	
	if(id != ''){
		$.ajax({
			url: 'clientInfo',
			data: {code: "json"},
			success: function(data){
				if(data.cv.profile == ""){
					$('#profile_image').css({
						backgroundImage: 'url("/resources/profile/default_client.png")',
						backgroundRepeat: "no-repeat",
						backgroundSize: "cover" 
					});
				}else{
					$('#profile_image').css({
						backgroundImage: 'url("/resources/profile/'+data.cv.profile+'")',
						backgroundRepeat: "no-repeat",
						backgroundSize: "cover" 
					});
				}
			}
		});
		
		$.ajax({
			url: 'clientInfo',
			data: {code: "not"},
			success: function(result){
				$('#client_result').html(result);
			}
		});
		
		$('#profile_image').click(function(){
			$('#client_info').slideToggle('slow');
		});
		
		$('#catmainlogo').click(function(){
			location.href = "catmain";
		});
		
		var angle = 0;
		$('#header_navigation_btn').click(function(){
			angle += 180;
			console.log(angle);
			$('#header_navigation_btn').css('transform','rotate('+angle+'deg)');
			$('.header_navigation').slideToggle('slow');
		});
	}else{
		$('.text').hover(function(){
			$(this).css({
					color:'red',
					cursor:'url("/resources/cursor/cat_hover.cur"), auto'
				});
			},
			function(){
				$(this).css({
					color:'black',
					cursor:'url("/resources/cursor/cat_default.cur"), auto'
				});
			}
		);
		
		$('img').hover(function(){
			$(this).css({
				cursor:'url("/resources/cursor/cat_hover.cur"), auto'
			});
		},function(){
			$(this).css({
				cursor:'url("/resources/cursor/cat_default.cur"), auto'
			});
		});
		
		$('#join').click(function() {
			location.href='JoinTerms';
		});
		
		$('#login').click(function(){
			location.href = 'loginf';
		});
		
		$('#home').click(function(e){
			location.href = "home";
		});
	}
});