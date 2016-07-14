require 'test_helper'

class PicksControllerTest < ActionController::TestCase
  setup do
    @pick = picks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:picks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pick" do
    assert_difference('Pick.count') do
      post :create, pick: { access_key: @pick.access_key, description: @pick.description, initial_balance: @pick.initial_balance, name: @pick.name, percentage: @pick.percentage, price: @pick.price, user_id: @pick.user_id, users_quantity: @pick.users_quantity }
    end

    assert_redirected_to pick_path(assigns(:pick))
  end

  test "should show pick" do
    get :show, id: @pick
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pick
    assert_response :success
  end

  test "should update pick" do
    patch :update, id: @pick, pick: { access_key: @pick.access_key, description: @pick.description, initial_balance: @pick.initial_balance, name: @pick.name, percentage: @pick.percentage, price: @pick.price, user_id: @pick.user_id, users_quantity: @pick.users_quantity }
    assert_redirected_to pick_path(assigns(:pick))
  end

  test "should destroy pick" do
    assert_difference('Pick.count', -1) do
      delete :destroy, id: @pick
    end

    assert_redirected_to picks_path
  end
end
