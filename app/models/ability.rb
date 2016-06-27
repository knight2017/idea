class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, Idea do |q|
      q.user == user
    end
    can :manage, Comment do |c|
      c.user == user
    end

  end
end
