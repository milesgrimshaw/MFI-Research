class MainController < ApplicationController
  
  def index
  end
  
  def generate_players
    ids = Borrower.all.map{|b| b.id}.shuffle
    game = Result.new
    game.left = Borrower.find(ids[0])
    game.right = Borrower.find(ids[1])
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
