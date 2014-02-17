# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require foundation/js/foundation
# require foundation/js/foundation/foundation.abide
# require foundation/js/foundation/foundation.accordion
# require foundation/js/foundation/foundation.alert
# require foundation/js/foundation/foundation.clearing
# require foundation/js/foundation/foundation.dropdown
#= require foundation/js/foundation/foundation.equalizer
# require foundation/js/foundation/foundation.interchange
# require foundation/js/foundation/foundation.joyride
# require foundation/js/foundation/foundation.magellan
# require foundation/js/foundation/foundation.offcanvas
# require foundation/js/foundation/foundation.orbit
# require foundation/js/foundation/foundation.reveal
# require foundation/js/foundation/foundation.tab
# require foundation/js/foundation/foundation.tooltip
#= require foundation/js/foundation/foundation.topbar
#= require_tree ./vendor
#= require_tree ./lib

$(document).foundation()

$(document).ready ->
  $("a#info").fancybox hideOnContentClick: true
  return

galleries = $(".ad-gallery").adGallery(
  start_at_index: 0
  update_window_hash: false
  description_wrapper: $("#descriptions")
  animation_speed: 400
  effect: 'fade'
)

galleries[0].addAnimation "no_desc", (img_container, direction, desc) ->
  if @current_description
    @current_description.remove()
    @current_description = `undefined`
  galleries[0].animations["fade"].apply this, [ img_container, direction, desc ]

galleries[0].settings.effect = "no_desc"
