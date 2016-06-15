require 'test_helper'

class SurvivorGamesControllerTest < ActionController::TestCase
  setup do
    @survivor_game = survivor_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survivor_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survivor_game" do
    assert_difference('SurvivorGame.count') do
      post :create, survivor_game: { description: @survivor_game.description, game_date: @survivor_game.game_date, handicap: @survivor_game.handicap, plus_handicap: @survivor_game.plus_handicap, survivor_week_game_id: @survivor_game.survivor_week_game_id, team2_id: @survivor_game.team2_id, team_id: @survivor_game.team_id, winner_team: @survivor_game.winner_team }
    end

    assert_redirected_to survivor_game_path(assigns(:survivor_game))
  end

  test "should show survivor_game" do
    get :show, id: @survivor_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survivor_game
    assert_response :success
  end

  test "should update survivor_game" do
    patch :update, id: @survivor_game, survivor_game: { description: @survivor_game.description, game_date: @survivor_game.game_date, handicap: @survivor_game.handicap, plus_handicap: @survivor_game.plus_handicap, survivor_week_game_id: @survivor_game.survivor_week_game_id, team2_id: @survivor_game.team2_id, team_id: @survivor_game.team_id, winner_team: @survivor_game.winner_team }
    assert_redirected_to survivor_game_path(assigns(:survivor_game))
  end

  test "should destroy survivor_game" do
    assert_difference('SurvivorGame.count', -1) do
      delete :destroy, id: @survivor_game
    end

    assert_redirected_to survivor_games_path
  end
end
