require 'test_helper'

class PickSurvivorWeeksControllerTest < ActionController::TestCase
  setup do
    @pick_survivor_week = pick_survivor_weeks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pick_survivor_weeks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pick_survivor_week" do
    assert_difference('PickSurvivorWeek.count') do
      post :create, pick_survivor_week: { pick_id: @pick_survivor_week.pick_id, survivor_week_game_id: @pick_survivor_week.survivor_week_game_id }
    end

    assert_redirected_to pick_survivor_week_path(assigns(:pick_survivor_week))
  end

  test "should show pick_survivor_week" do
    get :show, id: @pick_survivor_week
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pick_survivor_week
    assert_response :success
  end

  test "should update pick_survivor_week" do
    patch :update, id: @pick_survivor_week, pick_survivor_week: { pick_id: @pick_survivor_week.pick_id, survivor_week_game_id: @pick_survivor_week.survivor_week_game_id }
    assert_redirected_to pick_survivor_week_path(assigns(:pick_survivor_week))
  end

  test "should destroy pick_survivor_week" do
    assert_difference('PickSurvivorWeek.count', -1) do
      delete :destroy, id: @pick_survivor_week
    end

    assert_redirected_to pick_survivor_weeks_path
  end
end
