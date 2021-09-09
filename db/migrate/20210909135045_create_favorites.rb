class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.string :user_id
      t.string :post_id
      t.timestamps null: false
    end
  end
end
