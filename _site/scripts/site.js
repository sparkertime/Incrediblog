$(function() {
  if($.url.param('success') == 'true') {
    $("#success").show();
  }
  else if($.url.param('errors') == 'true') {
    $("#errors").show();
  }
});
