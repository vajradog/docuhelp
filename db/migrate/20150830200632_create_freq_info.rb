class CreateFreqInfo < ActiveRecord::Migration
  def change
    create_table :freq_infos do |t|
      t.string :content
      t.integer :page_id
      t.integer :user_id
      t.timestamps
    end
  end
end
