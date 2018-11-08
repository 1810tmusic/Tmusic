class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :song_no
      t.text :song
      t.integer :disc_id

      t.timestamps
    end
  end
end
