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
import "chartkick/chart.js"
import "chartkick/highcharts"
import "bootstrap"

// Import the specific modules you may need (Modal, Alert, etc)
import { Tooltip, Popover, Dropdown, Tab } from "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "stylesheets/application"
require('./nested-forms/addFields')
require('./nested-forms/removeFields')

$(document).on('turbolinks:load', function(){
	$(".chosen-select").chosen();
});

function stringToColor(string) {
  let hash = 0;
  let i;

  for (i = 0; i < string.length; i += 1) {
    hash = string.charCodeAt(i) + ((hash << 5) - hash);
  }

  let color = "#";

  for (i = 0; i < 3; i += 1) {
    const value = (hash >> (i * 8)) & 0xff;
    color += `00${value.toString(16)}`.substr(-2);
  }

  return color;
}

function stringAvatar(name) {
  let abbreviation = name[0];
  if (name.split(" ").length > 1) {
    abbreviation = name.split(" ")[0][0] + name.split(" ")[1][0];
  }
  return abbreviation;
}
