class Result < ActiveRecord::Base
  
  attr_accessible :left_id, :left_count, :right_id, :right_count
  
  belongs_to :left, :class_name => "Borrower"
  belongs_to :right, :class_name => "Borrower"
  
  # Returns winner of game
  def winner
    Borrower.find(self.winner_id)
  end
  
end
