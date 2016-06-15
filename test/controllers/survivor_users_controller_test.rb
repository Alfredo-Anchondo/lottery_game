require 'test_helper'

class SurvivorUsersControllerTest < ActionController::TestCase
  setup do
    @survivor_user = survivor_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survivor_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survivor_user" do
    assert_difference('SurvivorUser.count') do
      post :create, survivor_user: { purchase_date: @survivor_user.purchase_date, status: @survivor_user.status, survivor_week_game_id: @survivor_user.survivor_week_game_id, team_id: @survivor_user.team_id, user_id: @survivor_user.user_id }
    end

    assert_redirected_to survivor_user_path(assigns(:survivor_user))
  end

  test "should show survivor_user" do
    get :show, id: @survivor_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survivor_user
    assert_response :success
  end

  test "should update survivor_user" do
    patch :update, id: @survivor_user, survivor_user: { purchase_date: @survivor_user.purchase_date, status: @survivor_user.status, survivor_week_game_id: @survivor_user.survivor_week_game_id, team_id: @survivor_user.team_id, user_id: @survivor_user.user_id }
    assert_redirected_to survivor_user_path(assigns(:survivor_user))
  end

  test "should destroy survivor_user" do
    assert_difference('SurvivorUser.count', -1) do
      delete :destroy, id: @survivor_user
    end

    assert_redirected_to survivor_users_path
  end
end
