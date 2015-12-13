class UsersController < ApplicationController
  def dashboard
    @user = User.find(params[:id])
    @tasks = @user.tasks.paginate(:page => params[:page], :per_page => 10)
  end
end
