require 'test_helper'

class SurvivorWeekSurvivorsControllerTest < ActionController::TestCase
  setup do
    @survivor_week_survivor = survivor_week_survivors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survivor_week_survivors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survivor_week_survivor" do
    assert_difference('SurvivorWeekSurvivor.count') do
      post :create, survivor_week_survivor: { survivor_id_id: @survivor_week_survivor.survivor_id_id, survivor_week_games_id_id: @survivor_week_survivor.survivor_week_games_id_id }
    end

    assert_redirected_to survivor_week_survivor_path(assigns(:survivor_week_survivor))
  end

  test "should show survivor_week_survivor" do
    get :show, id: @survivor_week_survivor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survivor_week_survivor
    assert_response :success
  end

  test "should update survivor_week_survivor" do
    patch :update, id: @survivor_week_survivor, survivor_week_survivor: { survivor_id_id: @survivor_week_survivor.survivor_id_id, survivor_week_games_id_id: @survivor_week_survivor.survivor_week_games_id_id }
    assert_redirected_to survivor_week_survivor_path(assigns(:survivor_week_survivor))
  end

  test "should destroy survivor_week_survivor" do
    assert_difference('SurvivorWeekSurvivor.count', -1) do
      delete :destroy, id: @survivor_week_survivor
    end

    assert_redirected_to survivor_week_survivors_path
  end
end
