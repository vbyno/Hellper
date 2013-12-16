class Staff::TicketsController < ApplicationController
  load_and_authorize_resource exept: :index
  respond_to :js, only: :update

  def index
    authorize! :read, :ticket_list
    @tickets = Ticket.includes(:ticket_subject, :ticket_status)
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      CustomerMailer.ticket_updated(@ticket).deliver
      @reply = @ticket.replies.last
    else
      render action: 'edit'
    end
  end

private
  def ticket_params
    params[:ticket][:replies_attributes]['0'].merge!({ user_id: current_user.id })
    params.require(:ticket).permit(
      :ticket_status_id,
      replies_attributes: [:id, :body, :user_id, :ticket_id]
    )
  end
end