(($) ->
  # How many times should the letters be changed
  # Frames Per Second
  # Use this text instead of the contents
  # Run once the animation is complete

  # Preventing parallel animations using a flag;

  # The types array holds the type for each character;
  # Letters holds the positions of non-space characters;

  # Looping through all the chars of the string

  # Self executing named function expression:

  # This code is run options.fps times per second
  # and updates the contents of the page element
  # Fresh copy of the string

  # The animation is complete. Updating the
  # flag and triggering the callback;

  # All the work gets done here

  # The start argument and options.step limit
  # the characters we will be working on at once

  # Generate a random character at thsi position
  randomChar = (type) ->
    pool = ""
    if type is "lowerLetter"
      pool = "abcdefghijklmnopqrstuvwxyz0123456789"
    else if type is "upperLetter"
      pool = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    else if type is "number"
      pool = "0123456789"
    else pool = ",.?/\\(^)![]{}*&^%$#'\""  if type is "symbol"
    arr = pool.split("")
    arr[Math.floor(Math.random() * arr.length)]

  $.fn.shuffleLetters = (prop) ->
    options = $.extend(
      step: 50
      fps: 25
      text: ""
      callback: ->
    , prop)
    @each ->
      el = $(this)
      str = ""
      return true  if el.data("animated")
      el.data "animated", true
      if options.text
        str = options.text.split("")
      else
        str = el.text().split("")
      types = []
      letters = []
      i = 0

      while i < str.length
        ch = str[i]
        if ch is " "
          types[i] = "space"
          continue
        else if /[a-z]/.test(ch)
          types[i] = "lowerLetter"
        else if /[A-Z]/.test(ch)
          types[i] = "upperLetter"
        else if /[0-9]/.test(ch)
          types[i] = "number"
        else
          types[i] = "symbol"
        letters.push i
        i++
      el.html ""
      (shuffle = (start) ->
        i = undefined
        len = letters.length
        strCopy = str.slice(0)
        if start > len
          el.data "animated", false
          options.callback el
          return
        i = Math.max(start, 0)
        while i < len
          if i < start + options.step
            strCopy[letters[i]] = randomChar(types[letters[i]])
          else
            strCopy[letters[i]] = ""
          i++
        el.text strCopy.join("")
        setTimeout (->
          shuffle start + 1
          return
        ), 1000 / options.fps
        return
      ) -options.step
      return
  return) jQuery

$ ->
  $(".countdown").countdown({ date: "20 september 2014 15:30:00" });

$ ->
  # container is the DOM element;
  # userText is the textbox
  container = $("#shuffle")
  # Shuffle the contents of container
  container.shuffleLetters()

  $ ->
  $(".knob").knob
    change: (value) ->


      #console.log("change : " + value);
    release: (value) ->

      #console.log(this.$.attr('value'));
      console.log "release : " + value
      return

    cancel: ->
      console.log "cancel : ", this
      return

    draw: ->

      # "tron" case
      if @$.data("skin") is "tron"
        a = @angle(@cv) # Angle
        sa = @startAngle # Previous start angle
        sat = @startAngle # Start angle
        ea = undefined
        # Previous end angle
        eat = sat + a # End angle
        r = 1
        @g.lineWidth = @lineWidth
        @o.cursor and (sat = eat - 0.3) and (eat = eat + 0.3)
        if @o.displayPrevious
          ea = @startAngle + @angle(@v)
          @o.cursor and (sa = ea - 0.3) and (ea = ea + 0.3)
          @g.beginPath()
          @g.strokeStyle = @pColor
          @g.arc @xy, @xy, @radius - @lineWidth, sa, ea, false
          @g.stroke()
        @g.beginPath()
        @g.strokeStyle = (if r then @o.fgColor else @fgColor)
        @g.arc @xy, @xy, @radius - @lineWidth, sat, eat, false
        @g.stroke()
        @g.lineWidth = 2
        @g.beginPath()
        @g.strokeStyle = @o.fgColor
        @g.arc @xy, @xy, @radius - @lineWidth + 1 + @lineWidth * 2 / 3, 0, 2 * Math.PI, false
        @g.stroke()
        false


  # Example of infinite knob, iPod click wheel
  v = undefined
  up = 0
  down = 0
  i = 0
  $idir = $("div.idir")
  $ival = $("div.ival")
  incr = ->
    i++
    $idir.show().html("+").fadeOut()
    $ival.html i
    return

  decr = ->
    i--
    $idir.show().html("-").fadeOut()
    $ival.html i
    return

  $("input.infinite").knob
    min: 0
    max: 20
    stopper: false
    change: ->
      if v > @cv
        if up
          decr()
          up = 0
        else
          up = 1
          down = 0
      else
        if v < @cv
          if down
            incr()
            down = 0
          else
            down = 1
            up = 0
      v = @cv
      return

  return


