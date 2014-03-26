class JoinArticlesToCategories < ActiveRecord::Migration
  def up
    create_table :articles_categories, :id => false do |t|
      t.integer :article_id
      t.integer :category_id
    end
  end

  def down
    drop_table :articles_categories
  end
end
