class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :image
      t.string :name
      t.float :rating
      t.integer :played_count
    end
  end
end
