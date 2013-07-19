class TenantsController < ApplicationController
  before_action :authorize
  before_action :set_tenant, only:  [:show, :edit, :update, :destroy]
  
  # GET /tenants
  def index
    @title = t('.title')
    @tenants = Tenant.all
  end

  # GET /tenants/1
  def show
    @title = t('.title')
  end

  # GET /tenants/new
  def new
    @title = t('.title')
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
    @title = t('.title')
  end

  # POST /tenants
  def create
    @title = t('tenants.new.title')
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        format.html { redirect_to @tenant, notice: t('.success') }
        format.json { render action: 'show', status: :created, location: @tenant }
      else
        respond_with_error format, 'new'
      end
    end
  end

  # PATCH /tenants/1
  def update
    @title = t('tenants.edit.title')

    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: t('.success') }
        format.json { head :no_content }
      else
        respond_with_error format, 'edit'
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_tenant_url(@tenant), alert: t('.stale_object_error')
  end

  # DELETE /tenants/1
  def destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to tenants_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def respond_with_error format, action
    format.html { render action: action }
    format.json { render json: @tenant.errors, status: :unprocessable_entity }
  end

  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :email, :subdomain)
  end
end
