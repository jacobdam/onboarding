class MentorsController < ApplicationController
  def index
    @mentors = current_company.users.where(is_admin: false)
  end

  def show
    @mentor = current_company.users.find(params[:id])
  end
end
