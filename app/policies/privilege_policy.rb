class PrivilegePolicy < Policy

  def new?
    create?    
  end

  def create?
    has_permission?(:owner)
  end

  def destroy?
    has_permission?(:owner)
  end

  private

  def has_permission?(*permissions)
    utility = record.utility
    permissions.map! { |permission| Privilege.permissions[permission] }
    Privilege.where(user: user, utility: utility, permission: permissions).exists?
  end

end