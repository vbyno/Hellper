require 'spec_helper'
require 'cancan/matchers'

shared_examples 'it can read all' do
  it 'is able to read all' do
    expect(subject).to be_able_to(:read, :all)
  end
end

describe Ability do
  let(:user_ability) { Ability.new(build :user) }
  let(:customer_ability) { Ability.new(nil) }

  describe 'User ablility' do
    subject { user_ability }

    it_behaves_like 'it can read all'

    it 'is able to update tickets' do
      expect(subject).to be_able_to(:update, Ticket)
    end

    it 'is not able to create tickets' do
      expect(subject).not_to be_able_to(:create, Ticket)
    end
  end

  describe 'Customer ability' do
    subject { customer_ability }

    it_behaves_like 'it can read all'

    it 'is not able to update tickets' do
      expect(subject).not_to be_able_to(:update, Ticket)
    end

    it 'is able to create tickets' do
      expect(subject).to be_able_to(:create, Ticket)
    end
  end
end
