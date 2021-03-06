$(function(){
	var containerWidth = parseInt($('.container').css('width'));
	
	if(containerWidth < 800){
		$('.cmenu').css('width','100%');
	}else{
		$('.cmenu').css('width','50%');
	}
	
	var cmenuWidth = parseInt($('.cmenu').css('width'));
	$('.cmenu').css('height', (cmenuWidth*0.6)+'px');
	
	$(window).resize(function(){
		containerWidth = parseInt($('.container').css('width'));
		cmenuWidth = parseInt($('.cmenu').css('width'));
		
		if(containerWidth < 800){
			$('.cmenu').css('width','100%');
		}else{
			$('.cmenu').css('width','50%');
		}
		$('.cmenu').css('height', (cmenuWidth * 0.6)+'px');
	});
	
	$('.head_message').animate({
		'opacity': 1
	}, 2000);
	
	$('*').mouseup(function(e){
		e.stopImmediatePropagation();
		$('*').css('cursor', 'url("/resources/cursor/cat_default.cur"), auto');
	})
	
	$('*').mousedown(function(e){
		e.stopImmediatePropagation();
		$('*').css('cursor', 'url("/resources/cursor/cat_click.cur"), auto');
	});
	
	$(window).scroll(function(){
		var scrollTop = $(window).scrollTop();
		var scrollBottom = scrollTop + window.innerHeight;
		
		if(scrollBottom >= $('#diary').offset().top + (cmenuWidth * 0.6)){
			$('#cat_footprint').css('display','block');
			$('#cat_footprint').animate({
				width: '25%',
				height: '40%'
			}, 500);
		}
		
		if(scrollBottom >= $('#store').offset().top + (cmenuWidth * 0.6)){
			$('#truck').animate({
				right: '60%'
			}, 1000);
		}
		
		if(scrollBottom >= $('#gps').offset().top + (cmenuWidth * 0.6)){
			$('.location').css('display','block');
			$('#location1').animate({
				left: '64%',
				top: '73%'
			}, 300);
			$('#location2').animate({
				left: '70%',
				top: '75%'
			});
			$('#location3').animate({
				left: '64%',
				top: '89%'
			});
			$('#location4').animate({
				left: '62%',
				top: '80%'
			});
			$('#location5').animate({
				left: '69%',
				top: '82%'
			});
		}
	});
});