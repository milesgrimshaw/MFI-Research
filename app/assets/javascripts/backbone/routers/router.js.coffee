class TrustOrBust.Routers.Router extends Backbone.Router
    
  routes:
    ".*"        : "index"
  
  index: ->
    view = new TrustOrBust.Views.Index()