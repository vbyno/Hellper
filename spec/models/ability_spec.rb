require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:user_ability) { Ability.new(build :user) }
  let(:customer_ability) { Ability.new(nil) }

  context 'Ticket:' do
    describe 'User ablility' do
      it { expect(user_ability).to be_able_to(:read, Ticket) }
      it { expect(user_ability).to be_able_to(:edit, Ticket) }
      it { expect(user_ability).to be_able_to(:update, Ticket) }
      it { expect(user_ability).not_to be_able_to(:create, Ticket) }
    end

    describe 'Customer ability' do
      it { expect(customer_ability).to be_able_to(:read, Ticket) }
      it { expect(customer_ability).not_to be_able_to(:edit, Ticket) }
      it { expect(customer_ability).not_to be_able_to(:update, Ticket) }
      it { expect(customer_ability).to be_able_to(:create, Ticket) }
    end
  end
end
