class Subject < ActiveRecord::Base
  belongs_to :student
  belongs_to :message

  has_many :deliveries, dependent: :destroy

  def method_missing(method, *args, &block)
    message.send(method, *args, &block)
  end
end