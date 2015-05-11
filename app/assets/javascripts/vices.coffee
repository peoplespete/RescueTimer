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
        content: "<p>As I've thought about RescueTime's incredible amount of browsing data, I wonder, am I often a little distracted or rarely very distracted?  And does the distraction pattern follow a pattern by site or activity?
          </p>"
        highlightTarget: true
        nextButton: true
        target: $('#vice_manager_title')
        my: 'top center'
        at: 'bottom center'
      }
      {
        content: "<p>Assuming it does, I've mocked out a feature in which a user can categorize sites as a glancer (a site that is best used briefly in moments of boredom) or an engrosser (a site that is best used for extended periods to be beneficial).  This categorization could then be tied to a time management feature, which could limit access to these sites or activities.</p>"
        highlightTarget: true
        nextButton: true
        target: $('#category_header')
        my: 'top center'
        at: 'bottom center'
      }
      {
        content: "A user starts with a 50 minute allowance of time to use on glancers and engrossers"
        highlightTarget: true
        nextButton: true
        target: $('#total')
        my: 'bottom center'
        at: 'top center'
      }
      {
        content: "Start using a glancer and each minute (I sped up the minutes so it wouldn't get boring) counts as 1 minute until you reach the 5th minute.  Then each minute charges you 5 minutes.  By classifying the site as a glancer, you incentivise only glancing at the site."
        highlightTarget: true
        nextButton: true
        target: $('#remaining')
        my: 'bottom center'
        at: 'top center'
      }
      {
        content: "Start using an engrosser and each of the first 5 minutes counts as 5 minutes apiece since you shouldn't be using an engrosser for a short period.  Once you cross into the 6th minute each minute only counts as one minute and you have the first 5 overcharged minutes returned to you."
        highlightTarget: true
        nextButton: true
        target: $('#remaining')
        my: 'bottom center'
        at: 'top center'
      }
      {
        content: "Click on the site to start 'using' the website.  Notice how the color of the row changes depending on whether the time on that type of site is currently cheap or expensive."
        highlightTarget: true
        nextButton: true
        target: $('.name')
        my: 'top center'
        at: 'bottom center'
      }
      {
        content: "Click on the site to toggle off the website."
        highlightTarget: true
        nextButton: true
        target: $('.name')
        my: 'top center'
        at: 'bottom center'
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

