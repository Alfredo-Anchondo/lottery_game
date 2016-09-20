require 'test_helper'

class EnrachatesControllerTest < ActionController::TestCase
  setup do
    @enrachate = enrachates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enrachates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enrachate" do
    assert_difference('Enrachate.count') do
      post :create, enrachate: { description: @enrachate.description, end_date: @enrachate.end_date, initial_balance: @enrachate.initial_balance, initial_date: @enrachate.initial_date, percentage: @enrachate.percentage, price: @enrachate.price, type: @enrachate.type, winner: @enrachate.winner }
    end

    assert_redirected_to enrachate_path(assigns(:enrachate))
  end

  test "should show enrachate" do
    get :show, id: @enrachate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enrachate
    assert_response :success
  end

  test "should update enrachate" do
    patch :update, id: @enrachate, enrachate: { description: @enrachate.description, end_date: @enrachate.end_date, initial_balance: @enrachate.initial_balance, initial_date: @enrachate.initial_date, percentage: @enrachate.percentage, price: @enrachate.price, type: @enrachate.type, winner: @enrachate.winner }
    assert_redirected_to enrachate_path(assigns(:enrachate))
  end

  test "should destroy enrachate" do
    assert_difference('Enrachate.count', -1) do
      delete :destroy, id: @enrachate
    end

    assert_redirected_to enrachates_path
  end
end
