class TicketsController < ApplicationController
  before_action :set_ticket, only:  [:show, :edit, :update, :destroy]
  
  # GET /tickets
  def index
    @title = t('.title')
    @tickets = Ticket.all
  end

  # GET /tickets/1
  def show
    @title = t('.title')
  end

  # GET /tickets/new
  def new
    @title = t('.title')
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @title = t('.title')
  end

  # POST /tickets
  def create
    @title = t('tickets.new.title')
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: t('.success') }
        format.json { render action: 'show', status: :created, location: @ticket }
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
        format.html { redirect_to @ticket, notice: t('.success') }
        format.json { head :no_content }
      else
        respond_with_error format, 'edit'
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_ticket_url(@ticket), alert: t('.stale_object_error')
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def respond_with_error format, action
    format.html { render action: action }
    format.json { render json: @ticket.errors, status: :unprocessable_entity }
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:from_addresses, :subject, :body)
  end
end
