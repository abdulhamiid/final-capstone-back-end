class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin == true
      can :manage, :all
    else
      can :destroy, Reservation do |reservation|
        reservation.user == user
      end

      can :update, Reservation do |reservation|
        reservation.user == user
      end
      can :create, Reservation
      can :read, User, id: user.id
      can :read, Reservation, user_id: user.id
      can :read, FitnessActivity
    end
  end
end
