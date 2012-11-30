module StudentMessage::Deliverable
  extend ActiveSupport::Concern

  included do
    after_commit :queue_delivery_setup
  end

  def create_deliveries
    new_deliveries.each(&:save!)
  end

  def new_deliveries
    parents.inject([]) { |deliveries, parent| deliveries << delivery_for_parent(parent) }
  end

private

  def delivery_for_parent(parent)
    delivery = deliveries.new
    delivery.parent = parent
    delivery
  end

  def queue_delivery_setup
    Resque.enqueue(DeliverySetup, id)
  end
end