class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private
  def self.permit_admin_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        policy_admin?
      end
    end
  end

  def self.permit_admin_or_user_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        policy_admin_or_user?
      end
    end
  end

  def self.permit_admin_or_user_on_record_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        policy_admin_or_user_on_record?
      end
    end
  end

  def self.permit_admin_or_users_record_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        policy_admin_or_users_record?
      end
    end
  end

  def policy_admin?
    user.admin? unless !user
  end

  def policy_admin_or_user?
    user || user.admin? unless !user
  end

  def policy_admin_or_user_on_record?
    record.user_id == user.id || user.admin? unless !user
  end

  def policy_admin_or_users_record?
    record.id == user.id || user.admin? unless !user
  end
end
