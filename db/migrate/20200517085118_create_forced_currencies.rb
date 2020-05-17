class CreateForcedCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :forced_currencies do |t|
      t.references :currency, foreign: true
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.timestamp :dead_line, null: false

      t.timestamps
    end
  end
end
