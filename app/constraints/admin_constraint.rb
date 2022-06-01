# frozen_string_literal: true

class AdminConstraint
  def matches?(request)
    user_id = request.session[:user_id]
    user_id.present? && User.find_by(id: user_id)&.feature_enabled?(:super_admin)
  end
end
