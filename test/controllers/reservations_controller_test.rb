require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
  end

  test 'should get index' do
    get reservations_url, as: :json
    assert_response :success
  end

  test 'should create reservation' do
    assert_difference('Reservation.count') do
      @rese = @reservation
      post reservations_url,
           params: { reservation: { date: @rese.date, tutor_id: @rese.tutor_id, user_id: @rese.user_id } }, as: :json
    end

    assert_response :created
  end

  test 'should show reservation' do
    get reservation_url(@reservation), as: :json
    assert_response :success
  end

  test 'should update reservation' do
    @rese = @reservation
    patch reservation_url(@rese),
          params: { reservation: { date: @rese.date, tutor_id: @rese.tutor_id, user_id: @rese.user_id } }, as: :json
    assert_response :success
  end

  test 'should destroy reservation' do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation), as: :json
    end

    assert_response :no_content
  end
end
