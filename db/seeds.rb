# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create the admin credentials
User.create(name: "Administrator", role: "admin", password: "admin123")
User.create(name: "Hassan", password: "Hassan123")
User.create(name: "Josphat", password: "Josphat123")
Tutor.create(name: "Leehaney",  image: "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg", 
              speciality: "Python++", bio: "Best in Africa", price: 30)
Tutor.create(name: "Mike",  image: "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg", 
                speciality: "C++", bio: "Best in Africa", price: 30)
Tutor.create(name: "Tom",  image: "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg", 
                  speciality: "Golang", bio: "Best in Africa", price: 30)
Reservation.create(user_id: 1, tutor_id: 3, date: "15/05/2023")
Reservation.create(user_id: 2, tutor_id: 1, date: "16/05/2023")
Reservation.create(user_id: 3, tutor_id: 2, date: "17/05/2023")
Reservation.create(user_id: 1, tutor_id: 2, date: "18/05/2023")
Reservation.create(user_id: 2, tutor_id: 3, date: "19/05/2023")
Reservation.create(user_id: 2, tutor_id: 3, date: "19/05/2023")
