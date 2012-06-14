class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.references :album
    	t.string :url
			t.timestamps
    end
  end
end
