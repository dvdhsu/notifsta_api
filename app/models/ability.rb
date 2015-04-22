class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      # a global admin
      can :manage, :all
    else
      can :read, Event
      can :read, Channel
      can :read, Notification
      can :manage, Event do |e|
        # user admins the event
        e.admins.where(user_id: user.id).any?
      end
      can :manage, [Channel, Notification] do |o|
        # user admins the event that the object belongs to
        o.event.admins.where(user_id: user.id).any?
      end
      can :manage, Subscription do |s|
        # user is the event admin
        s.event.admins.where(user_id: user.id).any? ||
        # or it's my own subscription
        s.user_id == user.id
      end
      can [:create, :update, :destroy, :read], Response do |r|
        # can read as event admin
        r.event.admins.where(user_id: user.id).any? ||
        # or the response belongs to me
        r.user_id == user.id
      end
    end
  end
end
