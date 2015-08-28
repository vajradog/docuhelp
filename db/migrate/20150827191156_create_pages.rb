class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :ancestry

      t.timestamps
    end
    add_index :pages, :ancestry
  end
end
