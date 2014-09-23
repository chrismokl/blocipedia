class AddWikiToArticles < ActiveRecord::Migration
  def change
    add_belongs_to :articles, :wiki
  end
end
