class TenantsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    tenant = Tenant.find(params[:id])
    render json: tenant
  end

  def create
    tenant = Tenant.create(tenant_params)
    if tenant.valid?
      render json: tenant, status: :created
    else
      render json: {errors: tenant.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    tenant = Tenant.find(params[:id])
    tenant.update(tenant_params)
    if tenant.valid?
      render json: tenant, status: :accepted
    else
      render json: {errors: tenant.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    tenant = Tenant.find(params[:id])
    tenant.destroy
    head :no_content
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def render_not_found
    render json: {error: "Tenant not found"}, status: :not_found
  end

end