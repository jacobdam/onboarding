class CheckPointsController < ApplicationController
  def index
    @check_points = current_mentee.check_points
  end

  def destroy
    current_mentee.check_points.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  private

  def current_mentee
    @current_mentee ||= Mentee.find(params[:mentee_id])
  end
  helper_method :current_mentee
end
