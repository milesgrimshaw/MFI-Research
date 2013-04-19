class TrustOrBust.Models.Game extends Backbone.Model
  paramRoot: 'game'

  defaults:
    winner_id: null
    id: null
    
  decideWinner: (winnerId) =>
    console.log this
    $.ajax
       type: 'POST'
       dataType: 'json'
       url: '/games/' + @id + '/winner/' + winnerId
       success: (data) =>
         console.log data

class TrustOrBust.Collections.Games extends Backbone.Collection
  model: TrustOrBust.Models.Game
  url: '/games'
