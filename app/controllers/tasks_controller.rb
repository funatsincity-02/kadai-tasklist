class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  

  def index
    #@tasks = Task.all
    @tasks = current_user.tasks.all
    #@task = Task.new
    #binding.pry
    
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = '新規にタスクが登録されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクは登録できませんでした'
      #render 'tasks/index'
      render :new
      
    end
  end

  def new
    @task = Task.new
  end

  def edit
    #binding.pry
    #@task = Task.find(params[:id])
  end

  def show
    #@task = Task.find(params[:id])
  end

  def update
    #@task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは更新できませんでした'
      render :edit
    end
  end

  def destroy
    #@task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to root_url
    
  end


  private

  def task_params
  #binding.pry
    params.require(:task).permit(:content, :status)
  end


  def correct_user
    #binding.pry
    @task = current_user.tasks.find_by(id: params[:id])
    
    unless @task
      redirect_to tasks_url
    end
  end
    

end
