TrustOrBust.Views ||= {}

class TrustOrBust.Views.Index extends Backbone.View
  
  template: JST["backbone/templates/index"]
  bgTemplate: JST["backbone/templates/bg"]
  gameTemplate: JST["backbone/templates/game"]
  aboutTemplate: JST["backbone/templates/about"]
  boardTemplate: JST["backbone/templates/board"]
  leaderTemplate: JST["backbone/templates/leader"]

  el: 'body'
  
  initialize: ->
    $('body').on("keyup", @key)
    $(@el).html(@template)
    @renderCount()
  
  setCount: (count) ->
    $(".count span").html count
    
  renderCount: =>
    $.ajax
       type: 'GET'
       dataType: 'json'
       url: '/count'
       success: (data) =>
         @setCount(data)
         _.delay(@renderCount, 5000)
  
  # About Page
  renderAbout: ->
    $("#game").html(@aboutTemplate())
  
  # Leader board
  renderBoard: =>
    $("#game").html(@boardTemplate())
    @leaders = new TrustOrBust.Collections.Borrowers
    @leaders.url = "/leaders"
    @leaders.fetch success: (data) =>
      for borrower in data.models
        @addBorrower(borrower)
  
  addBorrower: (borrower) ->
    $("#game").append(@leaderTemplate(borrower: borrower))
      
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