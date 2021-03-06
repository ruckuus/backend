class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard
      if user.role == "author"
        can :create, [Place]
        can :update, [Place]
        can :read, [Place, Country, Category, City]
        can :create, [Country, Category, City] 
      elsif user.role == "admin"
        can :manage, :all
        can :read, :all 
      else user.role == "moderator"
        can :manage, [Place, Country, Category, City]
        can :read, :all 
      end
    end
  end
end
