class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name, unique: true
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
