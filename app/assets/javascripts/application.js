// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function add_fields(link, association, content) {
 	var new_id = new Date().getTime();
 	var regexp = new RegExp("(new_photos)", "g")
 	$('#photo_upload').append(content.replace(regexp, new_id));
//	$('.tags input').attr('name', new_id+'');
var name = $('.fields input:last').attr("name").replace('[pic]','[tags]');
$('.tags input').attr('name', name);
	$('.tags').removeClass('tags');
}
$('.present_image a').live('click', function(){$(this).parent('div').addClass('remove_me');});

