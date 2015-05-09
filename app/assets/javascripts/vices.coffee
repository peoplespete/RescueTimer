# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

is_glancer = (thissy) ->
  category = $(thissy).parent().children(".category").text()
  console.log category
  /glancer/i.test(category)

$(document).ready ->
  steps = [
    {
      content: '<p>First look at this thing</p>'
      highlightTarget: true
      nextButton: true
      target: $('.name')
      my: 'bottom center'
      at: 'top center'
    }
    {
      content: '<p>And then at this thing</p>'
      highlightTarget: true
      nextButton: true
      target: $('.category')
      my: 'bottom center'
      at: 'top center'
    }
  ]
  tour = new (Tourist.Tour)(
    steps: steps
    tipClass: 'Bootstrap'
    tipOptions: showEffect: 'slidein')

  tour.start()

  $("#total").text("50")
  $("#remaining").text($("#total").text()) #resets balance
  in_use = null

  $(".name").click ->
    if "in use" == $(this).text()
      # turning off
      $(this).text(in_use)
      in_use = null
      window.clearInterval(window.decreaser)# if window.decreaser
      engrossing_before = false

    else if in_use == null
      # turning on
      in_use = $(this).text()
      $(this).text("in use")

      remaining_at_start = parseInt( $("#remaining").text(), 10 )
      remaining = parseInt( $("#remaining").text(), 10 )
      glancer = is_glancer(this)
      engrossing_before = !glancer
      console.log engrossing_before
      window.decreaser = setInterval (->
        delta_so_far = remaining_at_start - remaining

        if glancer
          if delta_so_far > 5
            console.log "glancer after"
            change = 5
          else
            console.log "glancer before"
            change = 1
        else
          if delta_so_far < 20 && engrossing_before
            console.log "engrosser before"
            change = 5
          else
            console.log "engrosser after"
            remaining += (20-4) if engrossing_before # restores penalty for glancing use
            change = 1
            engrossing_before = false

        remaining -= change #(this number adjusts according to how much they've been on the site depending on site type)

        $("#remaining").text(remaining)
        return
      ), 600

