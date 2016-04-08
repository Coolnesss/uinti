class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :poke_id
      t.string :title

      t.timestamps null: false
    end
  end
end
