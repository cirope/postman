class RepliesController < ApplicationController
  include Responder

  before_action :authorize
  before_action :set_ticket
  before_action :set_reply, only:  [:show, :edit, :update, :destroy]
  before_action :set_title, only: [:show, :new, :edit]
  
  # GET /replies
  def index
    @title = t('.title', ticket: @ticket)
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
    @title = t('replies.new.title')
    @reply = @ticket.replies.new(reply_params)

    respond_to do |format|
      if @reply.save
        ResponseMailer.reply(@ticket, @reply.body).deliver

        format.html { redirect_to ticket, notice: t('.success') }
        format.json { render action: 'show', status: :created, location: [@ticket, @reply] }
      else
        respond_with_error format, 'new'
      end
    end
  end

  # PUT/PATCH /replies/1
  def update
    @title = t('replies.edit.title')

    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to ticket, notice: t('.success') }
        format.json { head :no_content }
      else
        respond_with_error format, 'edit'
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_ticket_reply_url(@ticket, @reply), alert: t('.stale_object_error')
  end

  # DELETE /replies/1
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to ticket, notice: t('.success') }
      format.json { head :no_content }
    end
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

  def ticket
    [@ticket.tenant, @ticket]
  end
end
