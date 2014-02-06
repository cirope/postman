class TenantsController < ApplicationController
  include Responder

  before_action :authorize
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:index, :show, :new, :edit]

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
    @title = t 'tenants.new.title'
    @tenant = Tenant.new tenant_params

    create_and_respond
  end

  # PATCH /tenants/1
  def update
    @title = t 'tenants.edit.title'

    update_and_respond
  end

  # DELETE /tenants/1
  def destroy
    destroy_and_respond
  end

  private

  def set_title
    @title = t '.title'
  end

  def set_tenant
    @tenant = Tenant.find params[:id]
  end

  def tenant_params
    params.require(:tenant).permit(:name, :email, :subdomain)
  end
  alias_method :resource_params, :tenant_params

  def resource
    @tenant
  end
end
