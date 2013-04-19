TrustOrBust.Views ||= {}

class TrustOrBust.Views.Index extends Backbone.View
  
  template: JST["backbone/templates/index"]
  bgTemplate: JST["backbone/templates/bg"]
  gameTemplate: JST["backbone/templates/game"]

  el: 'body'
  
  initialize: ->
    @render()
    
  renderGame: =>
    $("#game").html(@gameTemplate(game: @game))
  
  renderBackground: ->
    for i in [0..31]
      $(".background").append(@bgTemplate(url: 'http://www.kiva.org/img/200/259.jpg'))
     
  render: ->
    $('body').on("keyup", @key)
    $(@el).html(@template)
    @renderBackground()
  
  events:
    "click #new-game" : "newGame"
    "click .player" : "select"
  
  newGame: =>
    @game = new TrustOrBust.Models.Game
    @game.url = "/games/new"
    @game.fetch success: (data) =>
      @renderGame()
  
  select: (event) ->
    id = $(event.target).data("id")
    @game.decideWinner(id).then @newGame
  
  key: (event) =>
    if event.keyCode == 39
      # Right
      id = @game.get("right")
      @game.decideWinner(id).then @newGame
    else if event.keyCode == 37
      # Left
      id = @game.get("left")
      @game.decideWinner(id).then @newGame