class Permissions
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    if user.store_owner
      store_owner_permissions
    end
  end

  private

  def store_owner_permissions
    return true if controller == "items"
  end
end
