# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


(->
  voteUrl = "/vote/"
  refreshAfterLike = (data, parent_element) ->
    element = parent_element.children("#vote")
    switch data.response
      when "true"
        parent_element.removeClass "btn-default"
        parent_element.addClass "btn-primary"
        element.html parseInt(element.text()) + 1
      when "false"
        parent_element.removeClass "btn-primary"
        parent_element.addClass "btn-default"
        element.html parseInt(element.text()) - 1

  changeVote = ->
    element = $(this)
    addLike(element.attr("id")).done (data) ->
      refreshAfterLike data, element


  addLike = (creativeId) ->
    $.ajax
      url: voteUrl + creativeId
      dataType: "json"


  wireEvents = ->
    $(document).on "click", ".vote-button", changeVote

  $ ->
    wireEvents()

)()
