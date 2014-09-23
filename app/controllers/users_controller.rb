class UsersController < ApplicationController
    def show #write this to check to see if there's a params[id], if there is, find that user, otherwise, @User = current_user
      @user = params[:id] != nil ? User.friendly.find(params[:id]) : current_user
    end
    def index
      @users = User.all
    end
end
