class Result < ActiveRecord::Base
  
  attr_accessible :left_id, :right_id, :winner_id
  
  belongs_to :left, :class_name => "Borrower"
  belongs_to :right, :class_name => "Borrower"
  belongs_to :winner, :class_name => "Borrower"
  
  # Returns winner of game
  def winner
    Borrower.find(self.winner_id)
  end
  
end
