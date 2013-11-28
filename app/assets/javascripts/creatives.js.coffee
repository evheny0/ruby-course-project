# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


tagUrl = "/tags/start_with/"
$(".tags").tagsinput confirmKeys: [13, 32, 44]
$(".tags").tagsinput("input").typeahead(remote: tagUrl + "?q=%QUERY").bind "typeahead:selected", $.proxy((obj, datum) ->
  @tagsinput "add", datum.value
, $(".tags"))
