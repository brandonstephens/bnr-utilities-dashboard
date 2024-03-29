class BillPolicy < Policy

  def show?
    has_permission?(:read_write, :owner)
  end
  
  def new?
    true
  end

  def create?
    has_permission?(:read, :read_write, :owner)
  end

  def edit?
    update?
  end

  def update?
    has_permission?(:read_write, :owner)
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