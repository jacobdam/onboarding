class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to new_company_path unless current_company
  end
end
