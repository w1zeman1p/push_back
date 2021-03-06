# == Schema Information
#
# Table name: friend_requests
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class FriendRequest < ActiveRecord::Base
  validates :sender_id, :recipient_id, presence: true
  validates :sender_id, uniqueness: { scope: :recipient_id }
  validate :no_two_way_requests,
           :recipient_exists,
           :cant_request_self,
           :friendship_cant_exist

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  def accept
    friendship = Friendship.create_friendship(recipient_id, sender_id)
    self.destroy if friendship.persisted?
    friendship
  end

  def deny
    self.destroy
  end

  def self.build_for_user_and_fbid(user, fbid)
    recipient_auth = Authorization.find_by(uid: fbid)
    return FriendRequest.new if recipient_auth.nil?

    recipient = recipient_auth.user
    FriendRequest.new(sender: user, recipient: recipient)
  end

  private

  def no_two_way_requests
    # i.e. If request goes both ways, then friendship should be created
    request = FriendRequest.exists?(sender_id: self.recipient_id,
                                    recipient_id: self.sender_id)
    if request
      errors[:recipient_id] << "cannot request friendship back"
    end
  end

  def recipient_exists
    unless User.exists?(self.recipient_id)
      errors[:recipient_id] << "does not exist"
    end
  end

  def cant_request_self
    if recipient_id == sender_id
      errors[:sender_id] << "can't request friendship with self"
    end
  end

  def friendship_cant_exist
    if Friendship.exists?(user_id: sender_id, friend_id: recipient_id)
      errors[:sender_id] << "can't request friendship from a friend"
    end
  end
end
