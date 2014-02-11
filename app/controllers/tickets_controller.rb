class TicketsController < ApplicationController
  include Tickets::Email

  respond_to :html, :json, :js

  before_action :authorize, :set_tenant
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_title, except: [:index, :destroy]

  # GET /tickets
  def index
    @title = t '.title', owner: (@tenant || current_user)

    @tenant ? set_tickets_with_tenant : set_tickets_data

    respond_with *[@tenant, @tickets].compact
  end

  # GET /tickets/1
  def show
    @reply = @ticket.replies.new
    respond_with @ticket
  end

  # GET /tickets/new
  def new
    @ticket = @tenant.tickets.new
    respond_with @ticket
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  def create
    @ticket = @tenant.tickets.new ticket_params

    send_emails @ticket.message if @ticket.save
    respond_with @ticket
  end

  # PATCH /tickets/1
  def update
    @ticket.update ticket_params
    respond_with @ticket

  rescue ActiveRecord::StaleObjectError
    redirect_to [:edit, @ticket], alert: t('.stale')
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    respond_with @ticket, location: tenant_tickets_url(@tenant)
  end

  private

    def set_ticket
      @ticket = @tenant ? @tenant.tickets.find(params[:id]) : Ticket.find(params[:id])
      @tenant ||= @ticket.tenant
    end

    def set_tenant
      @tenant = Tenant.find params[:tenant_id] if params[:tenant_id]
    end

    def ticket_params
      params.require(:ticket).permit(
        :from_addresses, :subject, :status, :feedback_requested, :category_id, :user_id, :body
      )
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
