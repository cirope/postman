class TicketsController < ApplicationController
  include Responder
  include Tickets::Email

  before_action :authorize, :set_tenant
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:show, :new, :edit]
  
  # GET /tickets
  def index
    @title = t '.title', owner: (@tenant || current_user)
    
    @tenant ? set_tickets_with_tenant : set_tickets_data
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

    create_and_respond { send_emails @ticket.body }
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
    @ticket = @tenant ? @tenant.tickets.find(params[:id]) : Ticket.find(params[:id])
    @tenant ||= @ticket.tenant
  end

  def set_tenant
    @tenant = Tenant.find params[:tenant_id] if params[:tenant_id]
  end

  def set_title
    @title = t '.title'
  end

  def ticket_params
    params.require(:ticket).permit(
      :from_addresses, :subject, :status, :feedback_requested, :category_id, :user_id, :body
    )
  end
  alias_method :resource_params, :ticket_params

  def resource
    @ticket
  end
  alias_method :after_create_url, :resource
  alias_method :after_update_url, :resource

  def edit_resource_url
    edit_ticket_url @ticket
  end

  def after_destroy_url
    tenant_tickets_url @tenant
  end

  def set_tickets_with_tenant
    @tickets = @tenant.tickets.open.sorted.includes :category
  end

  def set_tickets_data
    @tickets = Ticket.loose_or_for(current_user).sorted
    @tickets_count = @tickets.count
    @last_ticket = @tickets.last
  end
end
