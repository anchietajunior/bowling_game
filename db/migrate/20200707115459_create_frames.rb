class CreateFrames < ActiveRecord::Migration[6.0]
  def change
    create_table :frames do |t|
      t.integer :number
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
