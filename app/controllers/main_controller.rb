class MainController < ApplicationController
  
  def index
  end
  
  def generate_players
    l = Random.rand(Borrower.count)
    r = Random.rand(Borrower.count)
    while l == r
      r = Random.rand(Borrower.count)
    end
    game = Result.new
    game.left = Borrower.find(l)
    game.right = Borrower.find(r)
    game.save
    render json: game.to_json(:include => ["left", "right"])
  end
  
  def decide_game
    game = Result.find(params[:id])
    game.winner_id = params[:winner_id]
    game.save
    left = game.left
    left.played_count += 1
    left.save
    right = game.right
    right.played_count += 1
    right.save
    render json: game
  end
  
end
