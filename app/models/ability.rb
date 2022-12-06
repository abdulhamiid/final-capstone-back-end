class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin == true
      can :manage, :all
    else
      can :read, Users, id: user.id
      can :read, Reservation, user_id: user.id
      can :read, FitnessActivity
    end
  end
end
