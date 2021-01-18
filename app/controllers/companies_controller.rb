class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Company #{@company.name} is created."
      redirect_to companies_path
    else
      flash[:error] = @company.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      flash[:success] = "Company #{@company.name} is updated."
      redirect_to companies_path
    else
      flash[:error] = @company.errors.full_messages.join(", ")
      render :edit
    end
  end  

  def destroy
    name = @company.name
    if @company.destroy
      flash[:success] = "#{name} is deleted successfully."
      redirect_to companies_path
    else
      flash[:error] = @company.errors.full_messages.join(", ")
      render :show
    end
  end


  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
      :color,
      services: []
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end

end
