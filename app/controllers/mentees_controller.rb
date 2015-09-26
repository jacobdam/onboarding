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
      input_mentor_ids = params[:mentee][:mentor_ids].select(&:present?).map { |id| id.to_i }
      input_mentor_ids.each do |id|
        @mentee.mentorships.where(user_id: id).create
      end
      redirect_to @mentee
    else
      render :new
    end
  end

  def update
    @mentee = current_company.mentees.find(params[:id])

    if @mentee.update_attributes(mentee_params)
      current_mentor_ids = @mentee.mentors.pluck(:id)
      input_mentor_ids = params[:mentee][:mentor_ids].select(&:present?).map { |id| id.to_i }

      removed_mentor_ids = current_mentor_ids - input_mentor_ids
      new_mentor_ids = input_mentor_ids - current_mentor_ids

      @mentee.mentorships.where(user_id: removed_mentor_ids).delete_all
      new_mentor_ids.each do |id|
        @mentee.mentorships.where(user_id: id).create
      end

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
