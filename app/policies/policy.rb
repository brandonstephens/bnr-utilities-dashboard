class Policy
  attr_reader :record, :user

  NotAuthorized = Class.new(StandardError)

  POLICIES = {
    Utility => UtilityPolicy
  }

  def self.for(record, user)
    policy_class = POLICIES.fetch(record.class)
    policy_class.new(record, user)
  end

  def initialize(record, user)
    @record = record
    @user = user
  end

  def authorize(action)
    raise NotAuthorized unless public_send("#{action}?")
  end

  def new?
    false
  end

  def create?
    false
  end

  def show?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end