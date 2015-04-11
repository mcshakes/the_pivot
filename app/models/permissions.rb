class Permissions
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    if user.store_admin?
      store_admin_permissions
    end
  end

  private

  def store_admin_permissions
    return true if controller == "items"
  end
end
