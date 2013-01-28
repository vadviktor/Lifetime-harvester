class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new
    @task.description = params[:description]
    time_parts = params[:time].split(':')
    @task.time_spent = (time_parts[0].to_i * 60 * 60) + (time_parts[1].to_i * 60) + time_parts[2].to_i
    @task.started = Time.now

    if @task.save
      redirect_to root_path, :success => 'Harvest begun and in progress'
    else
      redirect_to root_path, :error => 'Cannot start the harvest with these parameters'
    end
  end

  def update
  end

  def destroy
    @task = Task.find params[:id]
    if @task.destroy
      redirect_to root_path, :success => 'A harvester has been vanquished, cherish your newly gained moments'
    else
      redirect_to root_path, :error => 'The harvester could not be destroyed, try harder'
    end
  end

  def edit
  end

  def pause

  end

  def continue

  end
end
