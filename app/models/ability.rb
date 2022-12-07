class Ability
  include CanCan::Ability

  def initialize(user)
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
    end
  end
end
