# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$("input").on "change", ->
  $("input[type='radio']").each (c, e) ->
    $e = $(e)

    if ($e.is(":checked"))
      $("label[for='" + $e.attr("id") + "']").addClass("selected")
    else
      $("label[for='" + $e.attr("id") + "']").removeClass("selected")
