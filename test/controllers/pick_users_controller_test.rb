require 'test_helper'

class PickUsersControllerTest < ActionController::TestCase
  setup do
    @pick_user = pick_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pick_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pick_user" do
    assert_difference('PickUser.count') do
      post :create, pick_user: { local_score: @pick_user.local_score, pick_survivor_week_id: @pick_user.pick_survivor_week_id, pick_user_id: @pick_user.pick_user_id, points: @pick_user.points, user_id: @pick_user.user_id, visit_score: @pick_user.visit_score }
    end

    assert_redirected_to pick_user_path(assigns(:pick_user))
  end

  test "should show pick_user" do
    get :show, id: @pick_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pick_user
    assert_response :success
  end

  test "should update pick_user" do
    patch :update, id: @pick_user, pick_user: { local_score: @pick_user.local_score, pick_survivor_week_id: @pick_user.pick_survivor_week_id, pick_user_id: @pick_user.pick_user_id, points: @pick_user.points, user_id: @pick_user.user_id, visit_score: @pick_user.visit_score }
    assert_redirected_to pick_user_path(assigns(:pick_user))
  end

  test "should destroy pick_user" do
    assert_difference('PickUser.count', -1) do
      delete :destroy, id: @pick_user
    end

    assert_redirected_to pick_users_path
  end
end
