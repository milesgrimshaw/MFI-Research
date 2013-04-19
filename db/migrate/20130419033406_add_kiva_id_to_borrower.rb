class AddKivaIdToBorrower < ActiveRecord::Migration
  def change
    change_table :borrowers do |t|
      t.integer :kiva_id
    end
  end
end
