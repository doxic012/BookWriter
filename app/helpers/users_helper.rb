module UsersHelper
  def is_current_user?(user)
    current_user.eql?(user)
  end
end
