class Ticket < ApplicationRecord
	belongs_to :user
	belongs_to :journey
	belongs_to :start_station, class_name: 'Station'
	belongs_to :final_station, class_name: 'Station'

	delegate :name, to: :start_station, prefix: true
	delegate :name, to: :final_station, prefix: true

	validates :user, :journey, :start_station, :final_station, presence: true
	validate :check_stations_relation_to_journey
	validate :check_stations_order
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

	def check_stations_relation_to_journey
		return unless journey && start_station && final_station 
		station_ids = journey.stations.map(&:id)
		errors.add(:start_station_id, 'should belong to journey') unless station_ids.include?(start_station_id)
		errors.add(:final_station_id, 'should belong to journey') unless station_ids.include?(final_station_id)
	end

	def check_stations_order
		return unless journey && start_station && final_station
		stations = journey.stations
		start_station_position = stations.find_index { |station| station.id == start_station_id }
		final_station_position = stations.find_index { |station| station.id == final_station_id }
		errors.add(:base, 'Stations should be in correct order') if start_station_position >= final_station_position
	end

	def update_journey_seats_count
		journey.bus.update_column(:number_of_seats, journey.bus.number_of_seats - 1)
	end

	def journey_name
		"#{start_station_name} - #{final_station_name}" rescue journey.name
	end
	    
end
