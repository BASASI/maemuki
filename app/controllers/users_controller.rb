class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end
end
