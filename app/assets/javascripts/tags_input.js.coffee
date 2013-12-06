tagUrl = "/tags/start_with/"
$(".tags").tagsinput confirmKeys: [13, 32, 44]
$(".tags").tagsinput("input").typeahead(remote: tagUrl + "?q=%QUERY").bind "typeahead:selected", $.proxy((obj, datum) ->
  @tagsinput "add", datum.value
, $(".tags"))
