class TasksController < ApplicationController

  before_filter :find_task, :except => [:create, :index]

  def index
    if current_user
      @tasks = current_user.tasks.order(:description).all
      gon.harvest_in_progress = true if @tasks.detect { |t| t.harvesting? }
    end
  end

  def create
    @task = Task.new
    @task.user = current_user
    @task.description = params[:task][:description]
    @task.started = Time.now - timer_to_seconds(params[:task][:time_spent])

    if @task.save
      flash[:success] = 'Harvester on rampage'
      redirect_to root_path
    else
      flash.now[:error] = 'You are not the beholder of true names'
      redirect_to root_path
    end
  end

  def edit
    # if still harvesting then we have to stop it there
    if @task.finished.blank? and @task.started.present?
      @task.finished = Time.now
      @task.save
    end
  end

  def update
    @task.description = params[:task][:description]
    @task.finished = Time.now
    @task.started = @task.finished - timer_to_seconds(params[:task][:time_spent])

    if @task.save
      flash[:success] = 'Harvester ritual has changed, be prepared!'
      redirect_to root_path
    else
      flash.now[:error] = 'You are not the beholder of true names'
      redirect_to root_path
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = 'The harvester has been vanquished, cherish your newly gained moments'
      redirect_to root_path
    else
      flash.now[:error] = 'The harvester could not be destroyed, try harder'
      redirect_to root_path
    end
  end

  def pause
    @task.finished = Time.now
    if @task.save
      flash[:success] = 'Harvester is taking a rest, you should do as well'
      redirect_to root_path
    else
      flash.now[:error] = 'Harvester cannot be stopped, this method backfired'
      redirect_to root_path
    end
  end

  def reset
    @task.finished = nil
    @task.started = nil
    if @task.save
      flash[:success] = 'Harvester is taking a rest, you should do as well'
      redirect_to root_path
    else
      flash.now[:error] = 'Harvester cannot be stopped, this method backfired'
      redirect_to root_path
    end
  end

  def continue
    @task.started = Time.now - (@task.finished - @task.started).to_i
    @task.finished = nil
    if @task.save
      flash[:success] = 'Harvester got loose again'
      redirect_to root_path
    else
      flash.now[:error] = 'You are not the beholder of true names'
      redirect_to root_path
    end
  end

  private

  def timer_to_seconds(timer)
    time_parts = timer.split(':')
    (time_parts[0].to_i * 60 * 60) + (time_parts[1].to_i * 60) + time_parts[2].to_i
  end

  def find_task
    @task = Task.find params[:id]
  end
end
