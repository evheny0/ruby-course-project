# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


(->
  voteUrl = "/vote/"
  refreshAfterLike = (data, parent_element) ->
    element = parent_element.children("#vote")
    switch data.vote_is_set
      when "true"
        parent_element.removeClass "btn-default"
        parent_element.addClass "btn-primary"
        element.html data.vote_num
      when "false"
        parent_element.removeClass "btn-primary"
        parent_element.addClass "btn-default"
        element.html data.vote_num

  changeVote = ->
    element = $(this)
    addLike(element.attr("id")).done (data) ->
      refreshAfterLike data, element


  addLike = (creativeId) ->
    $.ajax
      type: "POST"
      url: voteUrl
      data: { id: creativeId }
      dataType: "json"


  wireEvents = ->
    $(document).on "click", ".vote-button", changeVote

  $ ->
    wireEvents()

)()
