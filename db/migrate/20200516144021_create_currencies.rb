class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name, unique: true
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.boolean :forced, default: false
      t.jsonb :forced_data, default: {}

      t.timestamps
    end
  end
end
