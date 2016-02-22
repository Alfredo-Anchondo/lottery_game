require 'test_helper'

class LotteriesControllerTest < ActionController::TestCase
  setup do
    @lottery = lotteries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lotteries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lottery" do
    assert_difference('Lottery.count') do
      post :create, lottery: { description: @lottery.description, final_number: @lottery.final_number, game_id: @lottery.game_id, initial_balance: @lottery.initial_balance, initial_number: @lottery.initial_number, price: @lottery.price, rules: @lottery.rules, winner_number: @lottery.winner_number }
    end

    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should show lottery" do
    get :show, id: @lottery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lottery
    assert_response :success
  end

  test "should update lottery" do
    patch :update, id: @lottery, lottery: { description: @lottery.description, final_number: @lottery.final_number, game_id: @lottery.game_id, initial_balance: @lottery.initial_balance, initial_number: @lottery.initial_number, price: @lottery.price, rules: @lottery.rules, winner_number: @lottery.winner_number }
    assert_redirected_to lottery_path(assigns(:lottery))
  end

  test "should destroy lottery" do
    assert_difference('Lottery.count', -1) do
      delete :destroy, id: @lottery
    end

    assert_redirected_to lotteries_path
  end
end
