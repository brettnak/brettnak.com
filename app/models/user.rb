class User < ActiveRecord::Base
  acts_as_authentic

  def admin?
    return email == "brettnak@gmail.com"
  end
end
