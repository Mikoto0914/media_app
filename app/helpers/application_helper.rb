module ApplicationHelper
  def account_name
    if current_user.name.empty?
      return current_user.email[/([\w\-.]+)@/, 1]
    else
      return current_user.name
    end
  end
end
