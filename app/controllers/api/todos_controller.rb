class Api::TodosController < ApplicationController
  def index
    @todos = Todo.all
    render json: @todos
  end


  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def show
    @todo = Todo.find(params[:id])
    if @todo
      render json: @todo
    else
      render json: "Not found"
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(todo_params)
      render json: @todo
    elsif @todo
      render json: @todo.errors.full_messages
    else
      render json: "Not found"
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo
      @todo.destroy
      render json: @todo.id
    else
      render json: "Not found"
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end
end
