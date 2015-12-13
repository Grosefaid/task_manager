class TasksController < ApplicationController
  before_action :find_task, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @tasks = Task.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def edit
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task.delete
    flash[:notice] = 'Задание удалено'
    redirect_to :tasks
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :user_id, :uploads_attributes => [:id, :file, :_destroy])
  end

end
