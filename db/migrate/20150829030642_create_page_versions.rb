class CreatePageVersions < ActiveRecord::Migration
  def change
    create_table :page_versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
      t.string   :author_username
      t.integer  :word_count
    end
    add_index :page_versions, [:item_type, :item_id]
  end
end
