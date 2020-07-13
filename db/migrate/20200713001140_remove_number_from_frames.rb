class RemoveNumberFromFrames < ActiveRecord::Migration[6.0]
  def change
    remove_column :frames, :number
  end
end
