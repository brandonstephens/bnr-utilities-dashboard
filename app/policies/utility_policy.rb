class UtilityPolicy < Policy

  def new?
    true
  end

  def create?
    true
  end

  def show?
    has_permission?(:owner, :read_write, :read)
  end

  def edit?
    update?
  end

  def update?
    has_permission?(:owner, :read_write)
  end
  
  def destroy?
    has_permission?(:owner)
  end

  private

  def has_permission?(*permissions)
    permissions.map! { |permission| Privilege.permissions[permission] }
    Privilege.where(user: user, utility: record, permission: permissions).exists?
  end

end