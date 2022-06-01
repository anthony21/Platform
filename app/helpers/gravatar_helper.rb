# frozen_string_literal: true

require 'digest'

module GravatarHelper
  def gravatar_image(user, css_class = nil)
    email_md5 = Digest::MD5.hexdigest(user.email.downcase)
    tag.image(
      src: "https://www.gravatar.com/avatar/#{email_md5}.jpg?d=robohash",
      class: css_class,
      title: user.display_name
    )
  end
end
