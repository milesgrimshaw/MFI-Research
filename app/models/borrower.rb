class Borrower < ActiveRecord::Base
  
  attr_accessible :name, :image, :rank
  has_many :left_results, :foreign_key => "left_id", :class_name => "Result"
  has_many :right_results, :foreign_key => "right_id", :class_name => "Result"
  
  before_create :set_played_count
  
  def set_played_count
    self.played_count = 0
  end
  
  # Returns all results
  def results
    self.left_results + self.right_results
  end
  
end
