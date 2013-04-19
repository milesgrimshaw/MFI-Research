TrustOrBust.Views ||= {}

class TrustOrBust.Views.Index extends Backbone.View
  
  template: JST["backbone/templates/index"]
  bgTemplate: JST["backbone/templates/bg"]
  gameTemplate: JST["backbone/templates/game"]

  el: 'body'
  
  initialize: ->
    $('body').on("keyup", @key)
    @render()
    
  renderGame: =>
    $("#game").html(@gameTemplate(game: @game))
  
  renderBackground: ->
    for i in [0..31]
      $(".background").append(@bgTemplate(url: 'http://www.kiva.org/img/200/259.jpg'))
     
  render: =>
    $(@el).html(@template)
    @game = new TrustOrBust.Models.Game
    @game.url = "/games/new"
    @game.fetch success: (data) =>
      @renderGame()
  
  events:
    "click #new-game" : "render"
    "click .player" : "select"    
  
  select: (event) ->
    id = $(event.target).data("id")
    id = $(event.target).parent().data("id") unless id
    @game.decideWinner(id).then @render
  
  key: (event) =>
    if event.keyCode == 39
      # Right
      id = @game.get("right").id
      @game.decideWinner(id).then @render
    else if event.keyCode == 37
      # Left
      id = @game.get("left").id
      @game.decideWinner(id).then @render