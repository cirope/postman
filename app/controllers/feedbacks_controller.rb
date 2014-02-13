class FeedbacksController < ApplicationController
  respond_to :html, :json

  before_action :authorize, only: [:index, :show]
  before_action :set_ticket, :set_tenant
  before_action :check_email, only: [:new, :create, :edit, :update]
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :set_title, except: [:index]

  # GET /feedbacks
  def index
    @title = t '.title', ticket: @ticket, tenant: @tenant
    @feedbacks = @ticket.feedbacks

    respond_with @ticket, @feedbacks
  end

  # GET /feedbacks/1
  def show
    respond_with @ticket, @feedback
  end

  # GET /feedbacks/new
  def new
    @feedback = @ticket.feedbacks.first_from params[:from]

    if @feedback
      redirect_to edit_ticket_url
    else
      @feedback = @ticket.feedbacks.new from: params[:from]

      respond_with @ticket, @feedback
    end
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
    @feedback = @ticket.feedbacks.new feedback_params

    @feedback.save
    respond_with @ticket, @feedback, location: edit_ticket_url
  end

  # PUT/PATCH /feedbacks/1
  def update
    update_resource @feedback, feedback_params, stale_location: [:edit, @ticket, @feedback]
    respond_with @ticket, @feedback, location: edit_ticket_url
  end

  private

    def set_feedback
      @feedback = @ticket.feedbacks.find_by! from: params[:id]
    end

    def set_ticket
      @ticket = Ticket.find params[:ticket_id]
    end

    def set_tenant
      @tenant = @ticket.tenant
    end

    def check_email
      email = params[:id] || params[:from] || feedback_params[:from]

      raise ActiveRecord::RecordNotFound unless @ticket.is_from? email
    end

    def feedback_params
      params.require(:feedback).permit :from, :score, :notes
    end

    def edit_ticket_url
      edit_ticket_feedback_url @ticket, @feedback
    end
end
