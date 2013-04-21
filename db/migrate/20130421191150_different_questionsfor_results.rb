class DifferentQuestionsforResults < ActiveRecord::Migration
  def change
    change_table :results do |t|
      t.boolean :question
    end
  end
end
