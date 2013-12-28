class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token, null: false
      t.text   :params
      t.timestamps
    end
  end
end
