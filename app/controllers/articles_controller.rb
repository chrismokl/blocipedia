class ArticlesController < ApplicationController
  
  before_action :set_wiki

  def set_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def show 
    @article = Article.find(params[:id])
  end

  def create
    @article = @wiki.articles.create(params.require(:article).permit(:title, :body))
    redirect_to wiki_article_path(@wiki, @article)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params.require(:article).permit(:title, :body))
    redirect_to wiki_article_path(@wiki)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to wiki_articles_path(@wiki)
  end

end
