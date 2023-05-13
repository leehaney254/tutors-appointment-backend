require 'rails_helper'

RSpec.describe Tutor, type: :model do
  before do
    @tutor = Tutor.new(name: 'tutor1', image: 'image1.com', speciality: 'speciality1', bio: 'bio1', price: 100)
  end

  it 'should be valid' do
    expect(@tutor).to be_valid
  end

  it 'should have a name' do
    expect(@tutor.name).to eq('tutor1')
  end

  it 'should have a image' do
    expect(@tutor.image).to eq('image1.com')
  end

  it 'should have a speciality' do
    expect(@tutor.speciality).to eq('speciality1')
  end

  it 'should have a bio' do
    expect(@tutor.bio).to eq('bio1')
  end

  it 'should have a price' do
    expect(@tutor.price).to eq(100)
  end
end
