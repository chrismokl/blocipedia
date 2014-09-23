class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @articles = @wiki.articles
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :privacy))
    authorize @wiki
    @wiki.save
    
    @collaboration = Collaboration.create(user: current_user, wiki: @wiki)
    redirect_to wikis_path
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
    redirect_to wikis_path #here
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.destroy
    redirect_to wikis_path
  end
end