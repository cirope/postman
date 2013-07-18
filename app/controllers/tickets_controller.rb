class TicketsController < ApplicationController
  before_action :authorize, :set_tenant
  before_action :set_ticket, only:  [:show, :edit, :update, :destroy]
  
  # GET /tickets
  def index
    @title = t('.title', tenant: @tenant)
    @tickets = @tenant.tickets
  end

  # GET /tickets/1
  def show
    @title = t('.title')
  end

  # GET /tickets/new
  def new
    @title = t('.title')
    @ticket = @tenant.tickets.new
  end

  # GET /tickets/1/edit
  def edit
    @title = t('.title')
  end

  # POST /tickets
  def create
    @title = t('tickets.new.title')
    @ticket = @tenant.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to [@tenant, @ticket], notice: t('.success') }
        format.json { render action: 'show', status: :created, location: [@tenant, @ticket] }
      else
        respond_with_error format, 'new'
      end
    end
  end

  # PATCH /tickets/1
  def update
    @title = t('tickets.edit.title')

    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to [@tenant, @ticket], notice: t('.success') }
        format.json { head :no_content }
      else
        respond_with_error format, 'edit'
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_tenant_ticket_url(@tenant, @ticket), alert: t('.stale_object_error')
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tenant_tickets_url(@tenant), notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def respond_with_error format, action
    format.html { render action: action }
    format.json { render json: @ticket.errors, status: :unprocessable_entity }
  end

  def set_ticket
    @ticket = @tenant.tickets.find params[:id]
  end

  def set_tenant
    @tenant = Tenant.find params[:tenant_id]
  end

  def ticket_params
    params.require(:ticket).permit(:from_addresses, :subject, :body)
  end
end
