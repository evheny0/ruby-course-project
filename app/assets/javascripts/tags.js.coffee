# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require raphael

o =
  init: ->
    @diagram()

  random: (l, u) ->
    Math.floor (Math.random() * (u - l + 1)) + l

  diagram: ->
    r = Raphael("diagram", 300, 300)
    rad = 120
    defaultText = "Tags\nammount"
    speed = 200
    start = o.random(91, 240)
    allValues = 0
    $("#get").find("li").each (i) ->
      t = $(this)
      allValues += parseInt(t.find("#value").attr("value"))

    colors = ["#97BE0D", "#D84F5F", "#88B8E6", "#BEDBE9", "#EDEBEE", "#8861E0", "#E5B07A", "#3AAD49", "#2267C9", "#DEDA68"]
    r.circle(150, 150, 85).attr
      stroke: "none"
      fill: "#193340"

    title = r.text(150, 150, defaultText).attr(
      font: "20px Arial"
      fill: "#fff"
    ).toFront()
    r.customAttributes.arc = (value, color, rad, start) ->
      v = 360 * (value / allValues)
      alpha = (if v is 360 then 359.99 else v)
      random = start
      a = (random - alpha) * Math.PI / 180
      b = random * Math.PI / 180
      sx = 150 + rad * Math.cos(b)
      sy = 150 - rad * Math.sin(b)
      x = 150 + rad * Math.cos(a)
      y = 150 - rad * Math.sin(a)
      path = [["M", sx, sy], ["A", rad, rad, 0, +(alpha > 180), 1, x, y]]
      path: path
      stroke: color

    $("#get").find("li").each (i) ->
      t = $(this)
      value = parseInt(t.find("#value").attr("value"))
      text = t.find("#value").text()
      start += 3.6 * (value / allValues * 100)
      z = r.path().attr(
        arc: [value, colors[i], rad, start]
        "stroke-width": 26
      )
      z.mouseover(->
        @animate
          "stroke-width": 50
          opacity: .75
        , 1000, "elastic"
        @toFront()  unless Raphael.type is "VML"
        title.stop().animate
          opacity: 0
        , speed, ">", ->
          @attr(text: text + "\n" + value).animate
            opacity: 1
          , speed, "<"

      ).mouseout ->
        @stop().animate
          "stroke-width": 26
          opacity: 1
        , speed * 4, "elastic"
        title.stop().animate
          opacity: 0
        , speed, ">", ->
          title.attr(text: defaultText).animate
            opacity: 1
          , speed, "<"
$ ->
  o.init()
