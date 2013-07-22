class RepliesController < ApplicationController
  include Responder

  before_action :authorize
  before_action :set_ticket
  before_action :set_reply, only:  [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:show, :new, :edit]
  
  # GET /replies
  def index
    @title = t '.title', ticket: @ticket
    @replies = @ticket.replies
  end

  # GET /replies/1
  def show
  end

  # GET /replies/new
  def new
    @reply = @ticket.replies.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  def create
    @title = t 'replies.new.title'
    @reply = @ticket.replies.new reply_params

    create_and_respond { ResponseMailer.delay.reply @ticket, @reply.body }
  end

  # PUT/PATCH /replies/1
  def update
    @title = t 'replies.edit.title'

    update_and_respond
  end

  # DELETE /replies/1
  def destroy
    destroy_and_respond
  end

  private

  def set_reply
    @reply = @ticket.replies.find params[:id]
  end

  def set_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  def set_title
    @title = t '.title'
  end

  def reply_params
    params.require(:reply).permit(:body)
  end
  alias_method :resource_params, :reply_params

  def resource
    @reply
  end

  def edit_resource_url
    edit_ticket_reply_url @ticket, @reply
  end

  def after_create_url
    [@ticket.tenant, @ticket]
  end
  alias_method :after_update_url, :after_create_url
  alias_method :after_destroy_url, :after_create_url
end
