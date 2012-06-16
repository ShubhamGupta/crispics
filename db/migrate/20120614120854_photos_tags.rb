class PhotosTags < ActiveRecord::Migration
  def up
  	create_table :photos_tags, :id => false do |t|
    	t.references :photo
    	t.references :tag
		end
		add_index :photos_tags, [:photo_id, :tag_id]
	end

  def down
  	drop_table :photos_tags
  end
end
