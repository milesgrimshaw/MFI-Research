class Borrower < ActiveRecord::Base
  
  attr_accessible :name, :image, :rank, :kiva_id
  has_many :left_results, :foreign_key => "left_id", :class_name => "Result"
  has_many :right_results, :foreign_key => "right_id", :class_name => "Result"
  has_many :wins, :foreign_key => "winner_id", :class_name => "Result"
  
  before_create :set_played_count
  
  validates_presence_of :kiva_id, :image
  validates_uniqueness_of :kiva_id, :image
  
  def set_played_count
    self.played_count = 0
  end
  
  # Returns all results
  def results
    self.left_results + self.right_results
  end
  
  def wins_count
    self.wins.count
  end
  
  def as_leader
    {
      "name" => name,
      "image" => image, 
      "played_count" => played_count,
      "wins" => wins.count
    }
  end
  
end
