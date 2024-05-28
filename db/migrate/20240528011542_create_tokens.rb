class CreateTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :tokens do |t|
      t.string :access_token, null: false
      t.datetime :access_token_expires_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tokens, :access_token, unique: true
  end
end
