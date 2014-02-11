class RepliesController < ApplicationController
  include Tickets::Email

  respond_to :html, :json

  before_action :authorize
  before_action :set_ticket
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  before_action :set_title, except: [:index, :destroy]

  # GET /replies
  def index
    @title = t '.title', ticket: @ticket
    @replies = @ticket.replies

    respond_with @ticket, @replies
  end

  # GET /replies/1
  def show
    respond_with @ticket, @reply
  end

  # GET /replies/new
  def new
    @reply = @ticket.replies.new
    respond_with @ticket, @reply
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  def create
    @reply = @ticket.replies.new reply_params

    @ticket.update! feedback_requested: true if params[:feedback_requested]

    send_emails @reply.message if @reply.save

    respond_with @ticket, @reply, location: @ticket
  end

  # PUT/PATCH /replies/1
  def update
    @reply.update reply_params
    respond_with @ticket, @reply, location: @ticket
  end

  # DELETE /replies/1
  def destroy
    @reply.destroy
    respond_with @ticket, @reply, location: @ticket
  end

  private

    def set_reply
      @reply = @ticket.replies.find params[:id]
    end

    def set_ticket
      @ticket = Ticket.find params[:ticket_id]
    end

    def reply_params
      params.require(:reply).permit(:body)
    end
end
