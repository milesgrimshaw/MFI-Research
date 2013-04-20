class TrustOrBust.Routers.Router extends Backbone.Router
  
  initialize: ->
    @view = new TrustOrBust.Views.Index()
     
  routes:
    "about"           : "about"
    "board"           : "board"
    "board/popular"   : "board"
    "board/unpopular" : "unpopular"
    ".*"              : "index"
  
  index: ->
    @view.render()
  
  about: ->
    @view.renderAbout()
  
  board: ->
    @view.renderBoard("popular")
  
  unpopular: ->
    @view.renderBoard("unpopular")