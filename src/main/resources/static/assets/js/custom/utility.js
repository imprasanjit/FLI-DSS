/*This is a custom script file containing common information*/

$(document).ready(function(){
$('li').removeClass('active');
	$('.menu-categories li a').each(function(){
	if($(this)[0]['href']==window.location.href)
	{
		$(this).parent('li').addClass('active');
	}
	});
});