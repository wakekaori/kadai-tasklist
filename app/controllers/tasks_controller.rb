class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.all
    end
  end
  
  def show
  end
  
  def new
    # @task = Task.new
    @task = current_user.tasks.build
  end
  
  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが登録できませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "タスクが削除されました"
    redirect_to tasks_url
  end
  
private

def set_task
  @task = Task.find(params[:id])
end
  
def task_params
  params.require(:task).permit(:content, :status)
end

def correct_user
  @task = current_user.tasks.find_by(id: params[:id])
  unless @task
    redirect_to root_url
  end
end

end