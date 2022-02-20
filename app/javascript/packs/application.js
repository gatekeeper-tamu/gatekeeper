// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'chosen-js/chosen.jquery'
import 'chosen-js'
// require("chosen")


require("chartkick")
require("chart.js")
require("bootstrap-sprockets")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "stylesheets/application"
require('./nested-forms/addFields')
require('./nested-forms/removeFields')


// function chosen_init() {
// 	$(".chosen-select").chosen().change(
// 		function(){
// 		var user = $('option:selected',this);
// 		var user_url = user.attr('data-url');
// 		$.getScript(user_url)
// 		}
// 	);
// }

$(document).on('turbolinks:load', function(){
	$(".chosen-select").chosen();
});