class Wikis::CollaborationsController < ApplicationController
  def index
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
  end
end
