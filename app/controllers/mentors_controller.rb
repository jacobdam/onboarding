class MentorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @mentors = current_company.users
  end
end
