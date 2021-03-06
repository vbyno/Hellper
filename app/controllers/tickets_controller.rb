class TicketsController < ApplicationController
  load_resource only: [:new, :show]
  authorize_resource only: :create

  def new; end
  def show; end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      # TODO Implement this via resque fail safe queue
      CustomerMailer.ticket_created(@ticket).deliver
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render action: 'new'
    end
  end

private
  def ticket_params
    params.require(:ticket).permit(
      :body,
      :customer_name,
      :customer_email,
      :ticket_subject_id
    )
  end
end