# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


tagUrl = "/tags/start_with/"
$(".tags").tagsinput confirmKeys: [13, 32, 44]
$(".tags").tagsinput("input").typeahead(remote: tagUrl + "?q=%QUERY").bind "typeahead:selected", $.proxy((obj, datum) ->
  @tagsinput "add", datum.value
, $(".tags"))



showNotification = (data) ->
  $(".notification-fixed").html data
  $(".notification-fixed").fadeIn("fast").delay(1000).fadeOut "fast"

resetActiveItem = ->
  $(".item").removeClass "active"

getOrderFromList = ->
  $("#chapters").sortable "toArray",
    attribute: "data-id"


updateOrder = ->
  showNotification "Updated"
  $("#chapters").find("a").each (i) ->
    $(this).attr "id", i


sendNewOrder = (order) ->
  $.ajax(url: creativeUrl + "/?order=" + getOrderFromList()).done updateOrder

deleteFromList = (item) ->
  showNotification "Deleted"
  $(".well").load creativeEditUrl
  item.remove()

deleteItem = ->
  parent = $(this).parent().parent()
  id = parseInt(parent.attr("data-id"))
  $.ajax(
    type: "DELETE"
    url: chapterUrl + id
  ).done deleteFromList(parent)

loadFormForItem = (id) ->
  unless id
    $(".well").load chapterUrl + id + "/edit.json"
  else
    $(".well").load creativeEditUrl

changeForm = ->
  resetActiveItem()
  $(this).addClass "active"
  id = parseInt($(this).attr("data-id"))
  loadFormForItem id

addItemToList = (order, id) ->
  resetActiveItem()
  $("#chapters").append newItem
  link = $(".active")
  link.attr "id", order
  link.attr "data-id", id

appendNewItem = (data) ->
  showNotification "Created"
  addItemToList data.order, data.id
  $(".well").load chapterUrl + data.id + "/edit.json"

createNewItem = ->
  $.ajax
    type: "POST"
    url: chapterUrl
    data:
      chapter:
        title: "New"

    success: appendNewItem


refreshIntervalId = null
startAutosave = ->
  refreshIntervalId = setInterval("sendForm(null)", 300000)

stopAutosave = ->
  clearInterval refreshIntervalId

refreshAfterSaving = (data) ->
  showNotification "Saved"
  refreshTitleInList data.title, data.order, data.id

refreshTitleInList = (title, order, id) ->
  link = $(".active")
  link.attr "id", order
  link.attr "data-id", id
  children = link.find(".list-group-item-heading").children()
  link.find(".list-group-item-heading").text title
  link.find(".list-group-item-heading").append children

sendForm = (func) ->
  $.ajax
    type: "post"
    url: ($(document).find(".edit_chapter")).attr("action") + ".json"
    data: ($(document).find(".edit_chapter")).serialize()
    success: func


$("#chapters").sortable cursor: "move"
$("#chapters").on "sortupdate", sendNewOrder
$(document).on "click", ".btn-danger", deleteItem
$(document).on "click", ".item", changeForm
$(".add").click createNewItem
$(document).on "submit", ".edit_chapter", (e) ->
  e.preventDefault()
  sendForm refreshAfterSaving

$(document).on "focusin", ".edit_chapter", startAutosave
$(document).on "focusout", ".edit_chapter", stopAutosave