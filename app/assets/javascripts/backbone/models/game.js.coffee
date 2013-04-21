class TrustOrBust.Models.Game extends Backbone.Model
  paramRoot: 'game'

  defaults:
    winner_id: null
    id: null
    
  decideWinner: (winnerId, question) =>
    if question = "lend it"
      question = true
    else
      question = false
    $.ajax
       type: 'POST'
       dataType: 'json'
       url: '/games/' + @id + '/winner/' + winnerId + "?question=" + question
       success: (data) =>
         # success

class TrustOrBust.Collections.Games extends Backbone.Collection
  model: TrustOrBust.Models.Game
  url: '/games'
