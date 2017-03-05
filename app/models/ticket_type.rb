class TicketType < ActiveRecord::Base
  belongs_to :event
  validates :price, numericality: true
end
