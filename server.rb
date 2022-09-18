require 'sinatra'
require 'json'

require 'sinatra/activerecord' # for db
require 'sinatra/namespace' # for api versioning namespace, made available by sinatra-contrib

set :database, {adapter: "sqlite3", database: "app.sqlite3"}

# MODEL
class Todo < ActiveRecord::Base
  validates_presence_of :todo
end

# CONFIGURES JSON REST API RESPONSES
before do
  content_type :json
end

# Monitoring
get '/uptime' do
  { status:"OK" }.to_json
end

# index route
get '/' do
  { info:"Todos API. Head over to /api/v1/todos for CRUD-OPS" }.to_json
end

# API
namespace '/api/v1' do
  # GET ALL
  get '/todos' do
    Todo.all.to_json
  end

  # GET Specific todo from its id
  get '/todos/:id' do
    @todo = Todo.find_by(id: params[:id])

    if @todo
      @todo.to_json
    else
      { error: "No todo found" }.to_json
    end
  end

  # Create a TODO
  post '/todos' do
    @todo = Todo.new(params)
    
    if @todo.save
      201
    else
      422
    end
  end

  # Update a TODO
  patch '/todos/:id' do
    @todo = Todo.where(id: params[:id]).first

    if @todo
      @todo.todo = params[:todo] if params.has_key?(:todo)
      @todo.completed = params[:completed] if params.has_key?(:completed)
      
      if @todo.save
        puts @todo.inspect
        {info:"Todo Updated!"}.to_json
      else
        422
      end
    else
      { error: "No todo found" }.to_json
    end
  end

  # Delete a Todo
  delete '/todos/:id' do
    @todo = Todo.where(id: params[:id]).first

    if @todo.destroy
      204
    else
      { error: "No todo found" }.to_json
    end
  end
end
