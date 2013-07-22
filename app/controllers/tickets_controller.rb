class TicketsController < ApplicationController
  include Responder

  before_action :authorize, :set_tenant
  before_action :set_ticket, only:  [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:show, :new, :edit]
  
  # GET /tickets
  def index
    @title = t '.title', tenant: @tenant
    @tickets = @tenant.tickets.includes :category
  end

  # GET /tickets/1
  def show
    @reply = @ticket.replies.new
  end

  # GET /tickets/new
  def new
    @ticket = @tenant.tickets.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @title = t 'tickets.new.title'
    @ticket = @tenant.tickets.new ticket_params

    create_and_respond { ResponseMailer.delay.reply @ticket, @ticket.body }
  end

  # PATCH /tickets/1
  def update
    @title = t 'tickets.edit.title'

    update_and_respond
  end

  # DELETE /tickets/1
  def destroy
    destroy_and_respond
  end

  private

  def set_ticket
    @ticket = @tenant.tickets.find params[:id]
  end

  def set_tenant
    @tenant = Tenant.find params[:tenant_id]
  end

  def set_title
    @title = t '.title'
  end

  def ticket_params
    params.require(:ticket).permit(:from_addresses, :subject, :status, :category_id, :body)
  end
  alias_method :resource_params, :ticket_params

  def resource
    @ticket
  end
  
  def after_create_url
    [@tenant, @ticket]
  end
  alias_method :after_update_url, :after_create_url

  def edit_resource_url
    edit_tenant_ticket_url @tenant, @ticket
  end

  def after_destroy_url
    tenant_tickets_url @tenant
  end
end
