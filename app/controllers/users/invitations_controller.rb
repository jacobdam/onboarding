class Users::InvitationsController < Devise::InvitationsController
  def create
    super do |user|
      user.update(company: current_company)
    end
  end
end
