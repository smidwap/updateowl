class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :student

  attr_accessible :body, :sender_id
end