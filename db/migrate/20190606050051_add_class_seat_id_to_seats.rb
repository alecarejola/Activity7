class AddClassSeatIdToSeats < ActiveRecord::Migration[5.2]
  def change
    add_column :seats, :class_seat_id, :integer
  end
end
