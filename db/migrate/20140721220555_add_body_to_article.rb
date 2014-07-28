class AddBodyToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :body, :string
  end
end
