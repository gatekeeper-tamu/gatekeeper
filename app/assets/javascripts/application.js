//= require jquery
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js

$(document).ready(function(){
    $('.datepicker').datepicker({
      format: 'dd/mm/yyyy',
      startDate: '0d',
      endDate: '+1y'
    });
  });
  