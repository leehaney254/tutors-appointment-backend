class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :image
      t.string :speciality
      t.string :bio
      t.decimal :price

      t.timestamps
    end
  end
end
