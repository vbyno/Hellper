require 'spec_helper'

shared_examples 'correct mail sender' do |email_type|
  it 'sends mail to customer with correct data' do
    expect(@mail.subject).to eq I18n.t("customer_mailer.#{email_type}.subject")
    expect(@mail.to).to eq [@ticket.customer_email]
    expect(@mail.from).to eq [
      Hellper::Application.config.customer_notification_email_address
    ]
  end

  xit 'sends mail with correct content' do
    # TODO Why mail body is empty in text environtment?
    expect(@mail.body).to have_content @ticket.reference
    expect(@mail.body).to have_content @ticket.customer_name
    expect(@mail.body).to have_css("a[href='#{ticket_url(@ticket)}']")
  end
end

describe CustomerMailer do
  describe'.ticket_created' do
    before :all do
      @ticket = create :ticket
      CustomerMailer.ticket_created(@ticket).deliver
      @mail = ActionMailer::Base.deliveries.last
    end

    it_behaves_like 'correct mail sender', 'ticket_created'
  end

  describe'.ticket_updated' do
    before :all do
      @ticket = create :ticket
      CustomerMailer.ticket_updated(@ticket).deliver
      @mail = ActionMailer::Base.deliveries.last
    end

    it_behaves_like 'correct mail sender', 'ticket_updated'
  end
end
