require 'account_role'

module Authorisable
  def role_for account
    role = AccountRole.where(account_id: account.id, user_id: id).first
    role || NullAccountRole.new
  end
end
