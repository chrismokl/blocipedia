class CollaborationsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = Collaboration.new(user: @user, wiki: @wiki)
    authorize @collaboration
    @collaboration.save

    redirect_to :back
  end

  def index
  end
end
