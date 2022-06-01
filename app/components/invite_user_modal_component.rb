# frozen_string_literal: true

class InviteUserModalComponent < ViewComponent::Base
include ComponentHelper

 def field_classes
   helpers.field_classes.join('')
 end
end
