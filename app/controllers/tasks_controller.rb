class TasksController < ApplicationController

  before_filter :find_task, :except => [:create, :index]

  def index
    @tasks = Task.all
    gon.harvest_in_progress = true if @tasks.detect {|t| t.harvesting? }
  end

  def create
    @task = Task.new
    @task.description = params[:description]
    time_parts = params[:time].split(':')
    @task.time_spent = (time_parts[0].to_i * 60 * 60) + (time_parts[1].to_i * 60) + time_parts[2].to_i
    @task.started = Time.now

    if @task.save
      redirect_to root_path, :success => 'Harvester on rampage'
    else
      redirect_to root_path, :error => 'You are not the beholder of true names'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @task.destroy
      redirect_to root_path, :success => 'The harvester has been vanquished, cherish your newly gained moments'
    else
      redirect_to root_path, :error => 'The harvester could not be destroyed, try harder'
    end
  end

  def pause
    @task.finished = Time.now
    @task.time_spent += (@task.finished - @task.started).to_i
    if @task.save
      redirect_to root_path, :success => 'Harvester is taking a rest, you should do as well'
    else
      redirect_to root_path, :error => 'Harvester cannot be stopped, this method backfired'
    end
  end

  def continue
    @task.finished = nil
    @task.started = Time.now
    if @task.save
      redirect_to root_path, :success => 'Harvester got loose again'
    else
      redirect_to root_path, :error => 'You are not the beholder of true names'
    end
  end

private

  def find_task
    @task = Task.find params[:id]
  end
end
