class ChangeTablePhotos < ActiveRecord::Migration
  def up
  	change_table :photos do |t|
			t.remove :url
			t.has_attached_file :pic
  	end
  end

  def down
  	change_table :photos do |t|
			t.string :url
			t.remove :pic
		end
  end
end
