class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render action: 'new'
    end
  end

  def show; end

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