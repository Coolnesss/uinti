class AddPokeNameToAchievement < ActiveRecord::Migration
  def change
    add_column :achievements, :poke_name, :string
  end
end
