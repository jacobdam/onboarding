class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to new_company_path unless current_company

    current_check_points = current_user.mentees.includes(:check_points).map do |mentee|
      mentee.current_check_point
    end.compact

    @answered_check_points = current_check_points.select do |check_point|
      check_point.answers.present?
    end

    @unanswered_check_points = current_check_points - @answered_check_points
  end
end
