class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :song_no, null: false
      t.text :song, null: false
      t.integer :disc_id, null: false

      t.timestamps
    end
  end
end
