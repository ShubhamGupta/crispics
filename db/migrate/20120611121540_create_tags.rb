class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
			t.references :photos
      t.timestamps
    end
  end
end
