class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.integer :overtuned_pins
      t.references :frame, null: false, foreign_key: true

      t.timestamps
    end
  end
end
