class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      user.is_admin = true
    end
  end
end
