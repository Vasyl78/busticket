class Ticket < ApplicationRecord
	belongs_to :user
	belongs_to :journey
	# belongs_to :start_station, class_name: 'Station'
	# belongs_to :final_station, class_name: 'Station'
# 
	# delegate :name, to: :start_station, prefix: true
	# delegate :name, to: :final_station, prefix: true

	delegate :name, to: :journey, prefix: true

	validate :check_bus_seats_availability
	after_create :update_journey_seats_count

	def price
		journey.routes.sum(:price)
	end

	def bus_id
		journey.bus.id
	end

	def dates
		"#{journey.routes.first.start_date} #{journey.routes.first.start_time} - #{journey.routes.last.final_date} #{journey.routes.last.final_time}"
	end

	def check_bus_seats_availability
		errors.add(:journey_id, 'has no available bus seats') if journey && journey.bus.number_of_seats <= 0
	end

	def update_journey_seats_count
		journey.bus.update_column(:number_of_seats, journey.bus.number_of_seats - 1)
	end
end
