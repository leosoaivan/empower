class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :staff
      can :manage, [Client, Episode, Contact]
    else
      can :read, :all
    end
  end
end
