# The CanCanCan Ability class defines the rules used when authorizing a user.
# @see https://github.com/bryanrite/cancancan CanCanCan on Github
class Ability
  include CanCan::Ability

  # Define abilities for the passed in user here.
  # @see https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  # @param user User the user you are granting permissions
  # @return Ability
  def initialize(user = nil)
    user ||= User.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, to: :crud
    if user.has_role?(:admin)
      can :manage, User
      can :manage, Authentication
      can :manage, Station
    else
      can [:read, :find],  Station
      can [:read, :create], Observation
      can :crud, User, id: user.id
      can :manage, Authentication do |auth|
        auth.user.id == user.id
      end
    end
  end
end