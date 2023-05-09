class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :tutor_id
      t.date :date

      t.timestamps
    end
  end
end
