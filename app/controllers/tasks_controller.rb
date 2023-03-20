class TasksController < ApplicationController
  before_action :authorize, dependent: :destroy #dependent: :destroy  <dùng để huỷ luôn items khi task bị huỷ>
  before_action :set_task, only: %i[show update destroy]
  before_action :set_status_task, only: [:update]

  # LIST TASKS (GET: /tasks)
  def index
    # @tasks = @user.tasks.all
    # @tasks = @user.tasks.ransack(params[:q]).result # search
    pagy, @tasks = pagy(@user.tasks.ransack(params[:q]).result)
    render json: { data: @tasks, pagy: serialize_pagy(pagy) }
    # render json: @tasks
  end

  # SHOW EACH TASKS (GET: /tasks/1)
  def show
    render json: @task
  end

  # NEW TASK (POST: /tasks)
  def create
    @task = Task.new(task_params.merge(user: @user))

    if @task.save
      render json: @task, status: 200, location: @task # location: @task  : ???
    else
      render json: @task.errors, status: 422
    end
  end

  # UPDATE (PATCH/PUT: /tasks/1)
  def update
    if @task.update(task_params)
      render json: @task, status: 200
    else
      render json: @task.errors, status: 422
    end
  end

  # DELETE (DELETE: /tasks/1)
  def destroy
    if @task.destroy
      render json: { message: 'Delete successful.' }, status: 200
    else
      render json: @task.errors, status: 422
    end
  end

  private

  def set_task
    @task = @user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :done, :deadline)
  end

  def serialize_pagy(pagy)
    data = pagy_metadata pagy
    {
      current_page: data[:page],
      next_page: data[:next],
      prev_page: data[:prev],
      total_pages: data[:pages],
      total_count: data[:count],
      per_page: data[:items]
    }
  end

  def set_status_task
    item = Item.where(Task_id: @task.id, status: ["doing","pending"])
    if item.count > 0
      render json: { message: "This task can't done. Because all item not done" }
    end
  end
end
