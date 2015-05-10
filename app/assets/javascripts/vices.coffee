# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

is_glancer = (thissy) ->
  category = $(thissy).parent().children(".category").text()
  console.log category
  /glancer/i.test(category)

$(document).ready ->
  console.log $.cookie("visit_counter")
  $.cookie("visit_counter", "0") if $.cookie("visit_counter") == null
  new_value = String(parseInt(  $.cookie "visit_counter" ) + 1)
  $.cookie "visit_counter", new_value
  if $.cookie("visit_counter") == "1"
    steps = [
      {
        content: '<p>Name of the website shown in this column</p>'
        highlightTarget: true
        nextButton: true
        target: $('.name')
        my: 'bottom center'
        at: 'top center'
      }
      {
        content: '<p>Sites are categorized as engrossers (these are sites that...) or glancers (these are sites that...)</p>'
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
    console.log "touring now"
    tour.start()

  $("#total").text("50")
  $("#remaining").text($("#total").text()) #resets balance

  $(".name").click ->
    tr = $(this).parent()
    in_use = tr.hasClass("success") || tr.hasClass("danger")
    if in_use
      # turning off
      # $(this).text(in_use)
      in_use = null
      window.clearInterval(window.decreaser)# if window.decreaser
      engrossing_before = false
      tr.removeClass("success")
      tr.removeClass("danger")

    else
      # turning on
      nothing_in_use = tr.parent().children(".success, .danger").length == 0
      if nothing_in_use
        remaining_at_start = parseInt( $("#remaining").text(), 10 )
        remaining = parseInt( $("#remaining").text(), 10 )
        glancer = is_glancer(this)
        engrossing_before = !glancer
        window.decreaser = setInterval (->
          delta_so_far = remaining_at_start - remaining

          if glancer
            if delta_so_far > 5
              console.log "glancer after"
              change = 5
              tr.removeClass("success")
              tr.addClass("danger")

            else
              console.log "glancer before"
              change = 1
              tr.addClass("success")
          else
            if delta_so_far < 25 && engrossing_before
              console.log "engrosser before"
              change = 5
              tr.removeClass("success")
              tr.addClass("danger")

            else
              console.log "engrosser after"
              remaining += (25-5) if engrossing_before # restores penalty for glancing use
              tr.removeClass("danger")
              tr.addClass("success")

              change = 1
              engrossing_before = false

          remaining -= change #(this number adjusts according to how much they've been on the site depending on site type)

          $("#remaining").text(remaining)
          return
        ), 600

