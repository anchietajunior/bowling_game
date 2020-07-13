class AddPointsToAttempts < ActiveRecord::Migration[6.0]
  def change
    add_column :attempts, :points, :integer
  end
end
