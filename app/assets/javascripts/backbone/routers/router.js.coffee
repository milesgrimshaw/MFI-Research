class TrustOrBust.Routers.Router extends Backbone.Router
  
  initialize: ->
    @view = new TrustOrBust.Views.Index()
     
  routes:
    "about"     : "about"
    "board"     : "board"
    ".*"        : "index"
  
  index: ->
    @view.render()
  
  about: ->
    @view.renderAbout()
  
  board: ->
    @view.renderBoard()