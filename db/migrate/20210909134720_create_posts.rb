class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :track_name
      t.string :artist_name
      t.string :collection_name
      t.text :comment
      t.string :image_url
      t.string :preview_url
      t.timestamps null: false
    end
  end
end
