// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .



$(function() {
	$(document).on("ajax:success", ".fav", function(e) {
		if ($('#' + e.detail[0]).hasClass('btn btn-info btn-xs')) {
			$('#' + e.detail[0]).removeClass('btn btn-info btn-xs').addClass('btn btn-danger btn-xs');
			$('#' + e.detail[0]).find('#ss' + e.detail[0]).text(" マイコレ削除");	
		} else if ($('#' + e.detail[0]).hasClass('btn btn-danger btn-xs')) {
			$('#' + e.detail[0]).removeClass('btn btn-danger btn-xs').addClass('btn btn-info btn-xs');
			$('#' + e.detail[0]).find('#ss' + e.detail[0]).text(" マイコレ追加");
		} else if ($('#' + e.detail[0]).hasClass('btn btn-info form-control')) {
			$('#' + e.detail[0]).removeClass('btn btn-info form-control').addClass('btn btn-danger form-control');
			$('#' + e.detail[0]).find('#ss' + e.detail[0]).text(" マイコレ削除");
		} else {
			$('#' + e.detail[0]).removeClass('btn btn-danger form-control').addClass('btn btn-info form-control');
			$('#' + e.detail[0]).find('#ss' + e.detail[0]).text(" マイコレ追加");
		}
    if ($('#aw' + e.detail[0]).hasClass('glyphicon glyphicon-music')) {
			$('#aw' + e.detail[0]).removeClass('glyphicon glyphicon-music').addClass('glyphicon glyphicon-trash');
		} else {
			$('#aw' + e.detail[0]).removeClass('glyphicon glyphicon-trash').addClass('glyphicon glyphicon-music');
		}
	})
})
