class Users::InvitationsController < Devise::InvitationsController
  def create
    self.resource = invite_resource
    resource.update_attributes(company: current_company)
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      respond_with resource, :location => after_invite_path_for(current_inviter)
    else
      respond_with_navigational(resource) { render :new }
    end
  end
end
