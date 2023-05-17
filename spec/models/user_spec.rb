require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.new(name: Faker::Name.name, password: 'password')
  end

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'should have a unique name' do
    User.create(name: 'user1', password: 'password')
    user2 = User.create(name: 'user1', password: 'password1')
    expect(user2).to_not be_valid
  end

  it 'should have a validate name' do
    expect(subject.name).to eq(@user.name)
  end
end
