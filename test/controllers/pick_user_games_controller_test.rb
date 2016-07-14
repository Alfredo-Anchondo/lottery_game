require 'test_helper'

class PickUserGamesControllerTest < ActionController::TestCase
  setup do
    @pick_user_game = pick_user_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pick_user_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pick_user_game" do
    assert_difference('PickUserGame.count') do
      post :create, pick_user_game: { pick_user_id: @pick_user_game.pick_user_id, survivor_game_id: @pick_user_game.survivor_game_id, team_id: @pick_user_game.team_id }
    end

    assert_redirected_to pick_user_game_path(assigns(:pick_user_game))
  end

  test "should show pick_user_game" do
    get :show, id: @pick_user_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pick_user_game
    assert_response :success
  end

  test "should update pick_user_game" do
    patch :update, id: @pick_user_game, pick_user_game: { pick_user_id: @pick_user_game.pick_user_id, survivor_game_id: @pick_user_game.survivor_game_id, team_id: @pick_user_game.team_id }
    assert_redirected_to pick_user_game_path(assigns(:pick_user_game))
  end

  test "should destroy pick_user_game" do
    assert_difference('PickUserGame.count', -1) do
      delete :destroy, id: @pick_user_game
    end

    assert_redirected_to pick_user_games_path
  end
end
