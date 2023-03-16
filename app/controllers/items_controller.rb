class ItemsController < ApplicationController
  before_action :authorize
  before_action :set_task
  before_action :set_item, only: [:show, :update, :destroy]
  

  # LIST ITEM (GET: /items)
  def index
    @items = @task.items.all
    render json: @items
  end

  # SHOW EACH ITEM (GET: /items/1)
  def show
    render json: @item
  end

  # NEW ITEM (POST: /items)
  def create
    # binding.pry
    @item = @task.items.new(item_params)
    if @item.save
      render json: @item, status: 200, location: @item # location: @item  : ???
    else
      render json: @item.errors, status: 422
    end
  end

  # UPDATE (PATCH/PUT: /items/1)
  def update
    if @item.update(item_params)
      render json: @item, status: 200
    else
      render json: @item.errors, status: 422
    end
  end

  # DELETE (DELETE: /items/1)
  def destroy
    if @item.destroy
      render json: { message: "Delete successful." }, status: 200
    else
      render json: @item.errors, status: 422
    end
  end

  private
    def set_task
      @task = Task.find_by(id: params[:task_id])
    end

    def set_item
      @item = @task.items.find_by(id: params[:id])
    end

    def item_params
      params.require(:item).permit(:title, :deadline, :status, :descrip)
    end
end
