class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :update, Ticket
    else
      can :create, Ticket
    end
  end
end
