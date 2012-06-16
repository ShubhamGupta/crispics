class RemovePhotosIdFromTags < ActiveRecord::Migration
  def up
  	remove_column(:tags, :photos_id)
  end

  def down
  	add_column(:tags, :photos_id)
  end
end
