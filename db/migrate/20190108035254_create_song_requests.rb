class CreateSongRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :song_requests do |t|
      t.references :invitation, foreign_key: true
      t.string :title, :null => false
      t.string :artist, :null => false

      t.timestamps
    end
  end
end
