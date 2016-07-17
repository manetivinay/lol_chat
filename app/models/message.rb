class Message < ApplicationRecord

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  #Scoping allows you to specify commonly-used queries which can be referenced as method calls on the association objects
  # or models
  # scope :unread, -> { where(read_at: nil) }

  # the '!' indicates at the end is a convention to hint that we are making changes to the message
  # the '!' indicates sometimes alos means that it may raise an error if the condition is not satisfied
  # int this case : we use  both meanings, because we also call save! inside, which means it will raise error if cannot save
  # def mark_as_read!
  #   self.read_at = Time.now
  #   save!
  # end
  #
  # #convenience
  # def read?
  #   read_at
  # end
end
