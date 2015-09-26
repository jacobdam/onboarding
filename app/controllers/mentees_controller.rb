class MenteesController < ApplicationController
  def new
    @mentee = current_company.mentees.new
  end

  def index
    @mentees = current_company.mentees
  end

  def create
    @mentee = current_company.mentees.create(mentee_params)

    if @mentee.valid?
      redirect_to @mentee
    else
      render :new
    end
  end

  def update
    @mentee = current_company.mentees.find(params[:id])
    if @mentee.update_attributes(mentee_params)
      redirect_to @mentee
    else
      render :edit
    end
  end

  def edit
    @mentee = current_company.mentees.find(params[:id])
  end

  def destroy
    @mentee = current_company.mentees.find(params[:id])
    @mentee.destroy
    redirect_to mentees_path
  end

  def show
    @mentee = current_company.mentees.find(params[:id])
  end

  private

  def mentee_params
    params.require(:mentee).permit(:name, :email)
  end
end
