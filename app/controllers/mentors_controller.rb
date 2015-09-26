class MentorsController < ApplicationController
  def new
    @mentor = User.new(company: current_company, is_admin: false)
  end

  def create
    @mentor = User.create(mentor_params)
    if @mentor.valid?
      redirect_to mentor_path(id: @mentor.id)
    else
      render :new
    end
  end

  def show
    @mentor = current_company.users.find(params[:id])
  end

  private

  def mentor_params
    params.require(:user).permit(:email, :full_name)
  end
end
