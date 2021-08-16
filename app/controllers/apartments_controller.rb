class ApartmentsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    apartments = Apartment.all
    render json: apartments
  end

  def show
    apartment = Apartment.find(params[:id])
    render json: apartment
  end

  def create
    apartment = Apartment.create(apartment_params)
    if apartment.valid?
      render json: apartment, status: :created
    else
      render json: {errors: apartment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    apartment = Apartment.find(params[:id])
    apartment.update(apartment_params)
    if apartment.valid?
      render json: apartment, status: :accepted
    else
      render json: {errors: apartment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    apartment = Apartment.find(params[:id])
    apartment.destroy
    head :no_content
  end

  private

  def apartment_params
    params.permit(:number)
  end

  def render_not_found
    render json: {error: "Apartment not found"}, status: :not_found
  end

end
