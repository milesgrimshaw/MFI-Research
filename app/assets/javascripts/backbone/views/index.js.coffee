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
  loadBoard: ->
    $("#leaders").removeClass("loading")
  
  setActive: (type) ->
    $("#game h1 a").removeClass("inactive")
    if type == "unpopular"
      $("#game h1 #popular").addClass "inactive"
    else
      $("#game h1 #unpopular").addClass "inactive"
    
  renderBoard: (type) =>
    $("#game").html(@boardTemplate())
    @setActive(type)
    @leaders = new TrustOrBust.Collections.Borrowers
    if type == "unpopular"
      @leaders.url = "/losers"
    else
      @leaders.url = "/leaders"
    @leaders.fetch success: (data) =>
      load = _.after(@leaders.length, @loadBoard)
      for borrower in data.models
        $("#leaders").append(@leaderTemplate(borrower: borrower))
        _.delay(load, 500)
  
  addBorrower: (borrower) ->
    $("#leaders").append(@leaderTemplate(borrower: borrower))
    @loadBoard()
      
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
    $(".player").addClass "loading"
    @game.decideWinner(id).then @render
  
  key: (event) =>
    if event.keyCode == 39
      # Right
      id = @game.get("right").id
      $(".player").addClass "loading"
      @game.decideWinner(id).then @render
    else if event.keyCode == 37
      # Left
      id = @game.get("left").id
      $(".player").addClass "loading"
      @game.decideWinner(id).then @render