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
  
  def count
    count = Result.count
    render json: count
  end
  
  def leaders
    borrowers = Borrower.all.sort_by{|b| -b.wins_count}
    borrowers = borrowers[0..100]
    render json: borrowers.to_json(:include => {:wins => {:only => ["id"]}})
  end
  
end
