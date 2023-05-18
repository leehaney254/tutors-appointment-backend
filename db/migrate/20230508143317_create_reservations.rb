class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.bigint :user_id
      t.bigint :tutor_id
      t.date :date

      t.timestamps
    end
  end
end
