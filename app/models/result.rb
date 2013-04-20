class Result < ActiveRecord::Base
  
  attr_accessible :left_id, :right_id, :winner_id
  
  belongs_to :left, :class_name => "Borrower"
  belongs_to :right, :class_name => "Borrower"
  belongs_to :winner, :class_name => "Borrower"
  
  # Returns winner of game
  def winner
    Borrower.find(self.winner_id)
  end
  
  def exp_left
    1 / (1 + 10**(((self.right.rating) - (self.left.rating)) / 400))
  end
  
  def exp_right
    1 / (1 + 10**(((self.left.rating) - (self.right.rating)) / 400))
  end
  
end
