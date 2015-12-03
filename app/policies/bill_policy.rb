class BillPolicy < Policy

  def show?
  end
  
  def new?
  end

  def create?
  end

  def edit?
  end

  def update?
  end

  def destroy?
  end

  private

  def has_permission?(*permissions)
  end

end