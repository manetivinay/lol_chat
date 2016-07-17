class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_insenssiitve: false}
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  has_secure_password

  #adding an Association anf the way we do that here is  Many to Many
  #this is to add the friends and (whom you want to add)
  has_many :friendships
  has_many :friends, :through => :friendships
  # this is for ==> who all Added you as a friend opposite side (opponent side)
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #incoming messages == received_messages
  def received_messages
    #User.where(recipient: self)
    Message.where(recipient_id: id)
  end

  #outgoing messages == sent_messages
  def sent_messages
    # User.where(sender: self)
    Message.where(sender_id: id)
  end

  # and we can "chain" methods to load n newest received messages
  def latest_received_messages(n)
    received_messages.order(created_at: :desc).limit(n)
  end


  def latest_send_messages(n)
    sent_messages.order(read_at: :desc).limit(n)
  end

  def unread_messages
    received_messages.unread
  end
end
