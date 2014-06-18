class TenantsController < ApplicationController
  respond_to :html, :json

  before_action :authorize
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]
  before_action :set_title, except: [:destroy]

  # GET /tenants
  def index
    @tenants = Tenant.all
  end

  # GET /tenants/1
  def show
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
  end

  # POST /tenants
  def create
    @tenant = Tenant.new tenant_params

    @tenant.save
    respond_with @tenant
  end

  # PATCH /tenants/1
  def update
    update_resource @tenant, tenant_params
    respond_with @tenant
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy
    respond_with @tenant
  end

  private

    def set_tenant
      @tenant = Tenant.find params[:id]
    end

    def tenant_params
      params.require(:tenant).permit :name, :email, :subdomain
    end
end
