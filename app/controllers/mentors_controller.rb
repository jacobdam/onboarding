class MentorsController < ApplicationController
  def show
    @mentor = current_company.users.find(params[:id])
  end
end
