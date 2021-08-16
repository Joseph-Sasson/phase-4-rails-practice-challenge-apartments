class LeasesController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def create
    lease = Lease.create(lease_params)
    if lease.valid?
      render json: lease, status: :created
    else
      render json: {errors: lease.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    lease = Lease.find(params[:id])
    lease.destroy
    head :no_content
  end

  private

  def lease_params
    params.permit(:tenant_id, :apartment_id, :rent)
  end

  def render_not_found
    render json: {error: "Lease not found"}, status: :not_found
  end

end
