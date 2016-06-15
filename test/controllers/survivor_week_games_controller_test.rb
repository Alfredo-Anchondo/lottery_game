require 'test_helper'

class SurvivorWeekGamesControllerTest < ActionController::TestCase
  setup do
    @survivor_week_game = survivor_week_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survivor_week_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survivor_week_game" do
    assert_difference('SurvivorWeekGame.count') do
      post :create, survivor_week_game: { final_date: @survivor_week_game.final_date, initial_date: @survivor_week_game.initial_date, survivor_id: @survivor_week_game.survivor_id, week: @survivor_week_game.week }
    end

    assert_redirected_to survivor_week_game_path(assigns(:survivor_week_game))
  end

  test "should show survivor_week_game" do
    get :show, id: @survivor_week_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survivor_week_game
    assert_response :success
  end

  test "should update survivor_week_game" do
    patch :update, id: @survivor_week_game, survivor_week_game: { final_date: @survivor_week_game.final_date, initial_date: @survivor_week_game.initial_date, survivor_id: @survivor_week_game.survivor_id, week: @survivor_week_game.week }
    assert_redirected_to survivor_week_game_path(assigns(:survivor_week_game))
  end

  test "should destroy survivor_week_game" do
    assert_difference('SurvivorWeekGame.count', -1) do
      delete :destroy, id: @survivor_week_game
    end

    assert_redirected_to survivor_week_games_path
  end
end
