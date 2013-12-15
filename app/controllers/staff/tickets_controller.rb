class Staff::TicketsController < ApplicationController
  authorize_resource exept: :index
  load_resource only: [:edit, :update]
  before_filter :can_view_ticket_list?, only: :index

  def index
    @tickets = Ticket.includes(:ticket_subject, :ticket_status)
  end

  def edit; end

  def update
    if @ticket.update(ticket_params)
      redirect_to staff_tickets_path, notice: 'Ticket was successfully updated.'
      CustomerMailer.ticket_updated(@ticket).deliver
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

  def can_view_ticket_list?
    can? :read, :ticket_list
  end
end