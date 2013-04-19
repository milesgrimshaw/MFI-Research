TrustOrBust.Views ||= {}

class TrustOrBust.Views.Index extends Backbone.View
  
  template: JST["backbone/templates/index"]
  bgTemplate: JST["backbone/templates/bg"]
  gameTemplate: JST["backbone/templates/game"]
  aboutTemplate: JST["backbone/templates/about"]

  el: 'body'
  
  initialize: ->
    $('body').on("keyup", @key)
    $(@el).html(@template)
    @renderCount()
  
  setCount: (count) ->
    $(".count").html count
    
  renderCount: =>
    $.ajax
       type: 'GET'
       dataType: 'json'
       url: '/count'
       success: (data) =>
         @setCount(data)
         _.delay(@renderCount, 1000)
  
  renderAbout: ->
    $("#game").html(@aboutTemplate())
      
  renderGame: ->
    $("#game").html(@gameTemplate(game: @game))
    $('<img class="image" src="' + @game.get("right").image + '"/>').load( @loadRightImage )
    $('<img class="image" src="' + @game.get("left").image + '"/>').load( @loadLeftImage )
  
  loadRightImage: ->
    $(".player.right").removeClass("loading")
  
  loadLeftImage: ->
    $(".player.left").removeClass("loading")
    
  render: =>
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