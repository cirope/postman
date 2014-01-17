class FeedbacksController < ApplicationController
  include Responder

  before_action :authorize, only: [:index, :show]
  before_action :set_ticket, :set_tenant
  before_action :check_email, only: [:new, :create, :edit, :update]
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:show, :new, :edit]

  # GET /feedbacks
  def index
    @title = t '.title', ticket: @ticket, tenant: @tenant
    @feedbacks = @ticket.feedbacks
  end

  # GET /feedbacks/1
  def show
  end

  # GET /feedbacks/new
  def new
    feedback = @ticket.feedbacks.first_from params[:from]

    redirect_to edit_ticket_feedback_url(@ticket, feedback) if feedback

    @feedback = @ticket.feedbacks.new from: params[:from]
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
    @title = t 'feedbacks.new.title'
    @feedback = @ticket.feedbacks.new feedback_params

    create_and_respond
  end

  # PUT/PATCH /feedbacks/1
  def update
    @title = t 'feedbacks.edit.title'

    update_and_respond
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

  def set_title
    @title = t '.title'
  end

  def check_email
    email = params[:id] || params[:from] || feedback_params[:from]

    raise ActiveRecord::RecordNotFound unless @ticket.is_from? email
  end

  def feedback_params
    params.require(:feedback).permit(:from, :score, :notes)
  end
  alias_method :resource_params, :feedback_params

  def resource
    @feedback
  end

  def after_create_url
    edit_ticket_feedback_url @ticket, @feedback
  end
  alias_method :after_update_url, :after_create_url
  alias_method :edit_resource_url, :after_create_url
end
