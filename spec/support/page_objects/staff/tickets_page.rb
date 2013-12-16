class Staff::TicketsPage < BasicPage
  def initialize
    @content = 'All Tickets'
    super(staff_tickets_path)
  end

  def fill_in_form(ticket_params)
    ticket_params.each do |label, value|
      fill_in label, with: value
    end
  end
end
