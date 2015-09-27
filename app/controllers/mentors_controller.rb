class MentorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @mentors = current_company.users
  end

  def show
    @mentor = current_company.users.find(params[:id])
  end
end
