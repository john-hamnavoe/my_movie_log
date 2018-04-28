# frozen_string_literal: true

module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80, class: 'gravatar' })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: options[:class])
  end

  def add_remove_friend_option(user)
    if current_user != user
      if !current_user.friends.include?(user) &&
        !current_user.pending_friends.include?(user)
          add_friend_tag(user)
      elsif current_user.friends.include?(user)
          remove_friend_tag(user)
      end
    end
  end

  def friend_status_option(user)
    if current_user != user
      if current_user.pending_friends.include?(user)
        ' (Pending Request!)'
      else
        ''
      end
    end
  end

  private

  def add_friend_tag(user)
    form_tag(friend_requests_path(friend_id: user.id), method: 'post') do
      submit_tag('add friend', class: 'btn btn-primary')
    end
  end

  def remove_friend_tag(user)
    form_tag(friends_destroy_path(id: user.id), method: 'delete') do
      submit_tag('remove friend', class: 'btn btn-default')
    end
  end
end
