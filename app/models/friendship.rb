class Friendship < ApplicationRecord
  belongs_to :user #belongs to user which is going to be who is goign to be initiator or owner of this friendship
  belongs_to :friend, :class_name => 'User' #belongs toa friend which is another user, because we can't determined by the name friend we need to specify the class name in here and say we want to use user has model fot this association
end
