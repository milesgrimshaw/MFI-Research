class MainController < ApplicationController
  
  def index
  end
  
  def generate_players
    ids = Borrower.all.map{|b| b.id}
    l = Random.rand(ids.count)
    r = Random.rand(ids.count)
    while l == r
      r = Random.rand(ids.count)
    end
    game = Result.new
    game.left = Borrower.find(ids[l])
    game.right = Borrower.find(ids[r])
    game.save
    render json: game.to_json(:include => ["left", "right"])
  end
  
  # Decide games based on Elo Rating System
  def decide_game
    game = Result.find(params[:id])
    game.winner_id = params[:winner_id]
    game.question = params[:question]
    game.save
    left = game.left
    left.played_count += 1
    if game.winner_id == left.id
      left.rating = left.rating + 32*(1 - game.exp_left)
    else
      left.rating = left.rating + 32*(0 - game.exp_left)
    end
    left.save
    right = game.right
    right.played_count += 1
    if game.winner_id == right.id
      right.rating = right.rating + 32*(1 - game.exp_right)
    else
      right.rating = right.rating + 32*(0 - game.exp_right)
    end
    right.save
    render json: game
  end
  
  def count
    count = Result.count
    render json: count
  end
  
  def leaders
    borrowers = Borrower.all.sort_by{|b| -b.rating}
    borrowers = borrowers[0..99]
    render json: borrowers.to_json(:include => {:wins => {:only => ["id"]}})
  end
  
  def losers
    borrowers = Borrower.all.sort_by{|b| b.rating}
    borrowers = borrowers[0..99]
    render json: borrowers.to_json(:include => {:wins => {:only => ["id"]}})
  end 
  
end
