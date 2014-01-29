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

#= require_tree ./vendor
#= require_tree ./lib

galleries = $(".ad-gallery").adGallery(
  start_at_index: 0
  update_window_hash: false
  description_wrapper: $("#descriptions")
)

galleries[0].addAnimation "no_desc", (img_container, direction, desc) ->
  if @current_description
    @current_description.remove()
    @current_description = `undefined`
  galleries[0].animations["slide-hori"].apply this, [ img_container, direction, desc ]

galleries[0].settings.effect = "no_desc"

# YUI(classNamePrefix: "pure").use "gallery-sm-menu", (Y) ->
#   horizontalMenu = new Y.Menu(
#     container: "#nav"
#     sourceNode: "#menu-items"
#     orientation: "horizontal"
#     hideOnOutsideClick: false
#     hideOnClick: false
#   )
#   horizontalMenu.render()
#   horizontalMenu.show()