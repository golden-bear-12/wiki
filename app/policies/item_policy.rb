class ItemPolicy < ApplicationPolicy
  def update?
    user.admin? || record.user == user || !record.private?  
  end
end
