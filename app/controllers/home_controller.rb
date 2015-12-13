class HomeController < ApplicationController
  def index
    @tasks = Task.paginate(:page => params[:page], :per_page => 10)
  end
end
