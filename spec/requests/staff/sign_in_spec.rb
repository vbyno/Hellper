require 'spec_helper'

describe 'sign_in' do
  let(:staff_sign_in_page) { Staff::SignInPage.new }
  let(:staff_tickets_page) { Staff::TicketsPage.new }
  let(:basic_page) { BasicPage.new }
  let(:user) { create :user }

  it 'allows user to log in and log out' do
    staff_sign_in_page.visit!.log_in(user)
    expect(staff_tickets_page).to be_loaded

    staff_sign_in_page.log_out!
    expect(basic_page).to be_loaded
  end

  it 'stays on same page if user data is incorrect' do
    user.password = 'incorrect'
    staff_sign_in_page.visit!.log_in(user)
    expect(staff_sign_in_page).to be_loaded
  end
end
