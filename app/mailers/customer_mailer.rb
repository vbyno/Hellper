class CustomerMailer < ActionMailer::Base
  default from: Hellper::Application.config.customer_notification_email_address

  def ticket_created(ticket)
    @ticket = ticket
    mail(to: @ticket.customer_email,
         subject: I18n.t('customer_mailer.ticket_created.subject'))
  end
end
