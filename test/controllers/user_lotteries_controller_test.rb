require 'test_helper'

class UserLotteriesControllerTest < ActionController::TestCase
  setup do
    @user_lottery = user_lotteries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_lotteries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_lottery" do
    assert_difference('UserLottery.count') do
      post :create, user_lottery: { lottery_id: @user_lottery.lottery_id, purchase_date: @user_lottery.purchase_date, status: @user_lottery.status, ticket_number: @user_lottery.ticket_number, user_id: @user_lottery.user_id }
    end

    assert_redirected_to user_lottery_path(assigns(:user_lottery))
  end

  test "should show user_lottery" do
    get :show, id: @user_lottery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_lottery
    assert_response :success
  end

  test "should update user_lottery" do
    patch :update, id: @user_lottery, user_lottery: { lottery_id: @user_lottery.lottery_id, purchase_date: @user_lottery.purchase_date, status: @user_lottery.status, ticket_number: @user_lottery.ticket_number, user_id: @user_lottery.user_id }
    assert_redirected_to user_lottery_path(assigns(:user_lottery))
  end

  test "should destroy user_lottery" do
    assert_difference('UserLottery.count', -1) do
      delete :destroy, id: @user_lottery
    end

    assert_redirected_to user_lotteries_path
  end
end
