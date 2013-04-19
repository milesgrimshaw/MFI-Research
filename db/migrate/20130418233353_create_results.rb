class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :left_id
      t.integer :right_id
      t.integer :winner_id
    end
  end
end
