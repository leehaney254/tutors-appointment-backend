require 'rails_helper'

RSpec.describe 'Reservation', type: :model do
  before do
    @user = User.create(name: Faker::Name.name, password: 'password')
    @tutor = Tutor.create(name: Faker::Name.name, image: 'image1.com', speciality: 'speciality1', bio: 'bio1', price: 100)
    @reservation = Reservation.new(user_id: @user.id, tutor_id: @tutor.id, date: '2021-04-20')
  end

  it 'should be valid' do
    expect(@reservation).to be_valid
  end

  it 'should have a user_id' do
    expect(@reservation.user_id).to eq(@user.id)
  end

  it 'should have a tutor_id' do
    expect(@reservation.tutor_id).to eq(@tutor.id)
  end

  it 'should have a date' do
    expect(@reservation.date).to eq(Date.new(2021, 4, 20))
  end
end
