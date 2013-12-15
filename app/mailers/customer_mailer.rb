class CustomerMailer < ActionMailer::Base
  default from: Hellper::Application.config.customer_notification_email_address

  [:ticket_created, :ticket_updated].each do |method_name|
    define_method method_name do |ticket|
      @ticket = ticket
      mail(to: @ticket.customer_email,
           subject: I18n.t("customer_mailer.#{method_name}.subject"))
    end
  end
end
