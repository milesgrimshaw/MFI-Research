class TrustOrBust.Models.Borrower extends Backbone.Model
  paramRoot: 'borrower'

  defaults:
    image: null
    
class TrustOrBust.Collections.Borrowers extends Backbone.Collection
  model: TrustOrBust.Models.Borrower
  url: '/borrowers'