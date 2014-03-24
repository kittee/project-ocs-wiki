class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :article_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
