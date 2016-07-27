class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.text :term

      t.timestamps
    end
  end
end
