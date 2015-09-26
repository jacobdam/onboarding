class MentorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @mentors = current_company.users
  end

  def show
    @mentor = current_company.users.find(params[:id])
  end
end
