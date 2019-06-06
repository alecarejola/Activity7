class Seat < ApplicationRecord
    belongs_to :flight
    belongs_to :seat_class

    validate :check_capacity
    validate :check_baggage

    private
    def check_capacity
        seats = Seat.where(flight_id: flight_id).length
        capacity = Flight.find(flight_id).capacity

        if seats >= capacity then
            errors.add(:flight_id, "The flight is full")
        end
    end
    def check_baggage
        seats = Seat.where(flight_id: flight_id)
        
        sum_baggage = 0

        #accumulator
        seats.each do |s|
            sum_baggage += s.baggage.to_f
        end

        baggage_capacity = Flight.find(flight_id).baggage_allowance

        if sum_baggage + baggage > baggage_capacity then
            errors.add(:baggage, "The baggage must not exceed by " + (-1 *( baggage_capacity - sum_baggage - baggage )).to_s)
        end
    end
end
