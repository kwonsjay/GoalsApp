class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :author_id, null: false
      t.boolean :private, default: false
      t.timestamps
    end
  end
end
