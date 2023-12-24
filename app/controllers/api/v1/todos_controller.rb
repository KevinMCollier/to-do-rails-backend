class Api::V1::TodosController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_todo, only: [:show, :update, :destroy]

  # POST /todos
  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # GET /todos
  def index
    puts "Current User: #{current_user.inspect}"  # Debugging statement
    @todos = current_user.todos
    render json: @todos
  end

  # GET /todos/by_date
  def by_date
    date = Date.parse(params[:date])
    @todos = Todo.filter_by_date(current_user.id, date)
    render json: @todos
  end

  # GET /todos/:id
  def show
    render json: @todo
  end

  # PUT /todos/:id
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :date, :repeat, :day_of_week)
  end
end
