class CheckPointsController < ApplicationController
  def index
    @check_points = current_mentee.check_points.includes(:question).order(start_date: :asc)
  end

  def destroy
    current_mentee.check_points.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  def new
    @check_point = current_mentee.check_points.build
  end

  def create
    @check_point = current_mentee.check_points.build(check_point_params)
    if @check_point.save
      redirect_to action: 'index', notice: 'Check point created'
    else
      render action: 'new'
    end
  end

  def edit
    @check_point = current_mentee.check_points.find(params[:id])
  end

  def update
    @check_point = current_mentee.check_points.find(params[:id])
    if @check_point.update(check_point_params)
      redirect_to action: 'index', notice: 'Check point updated'
    else
      render action: 'edit'
    end
  end

  def finish
    CheckPointService.new(check_point).finish!
    redirect_to action: 'index'
  end

  private

  def check_point
    @check_point ||= current_mentee.check_points.find(params[:id])
  end

  def current_mentee
    @current_mentee ||= Mentee.find(params[:mentee_id])
  end
  helper_method :current_mentee

  def check_point_params
    params.require(:check_point).permit(
      :start_date,
      :question_attributes =>[
        :name
      ]
    )
  end
end
