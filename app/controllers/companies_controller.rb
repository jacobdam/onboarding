class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      current_user.update!(company: @company)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @company = current_company
  end

  def update
    @company = current_company
    if @company.update(company_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  protected

  def company_params
    params.require(:company).permit(:name)
  end
end
