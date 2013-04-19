class TrustOrBust.Routers.Router extends Backbone.Router
  
  initialize: ->
    @view = new TrustOrBust.Views.Index()
     
  routes:
    "about"     : "about"
    ".*"        : "index"
  
  index: ->
    @view.render()
  
  about: ->
    @view.renderAbout()