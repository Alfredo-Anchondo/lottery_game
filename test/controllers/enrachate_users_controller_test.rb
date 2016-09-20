require 'test_helper'

class EnrachateUsersControllerTest < ActionController::TestCase
  setup do
    @enrachate_user = enrachate_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enrachate_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enrachate_user" do
    assert_difference('EnrachateUser.count') do
      post :create, enrachate_user: { answer: @enrachate_user.answer, purchase_date: @enrachate_user.purchase_date, question_enrachate_id: @enrachate_user.question_enrachate_id, status: @enrachate_user.status, tira_enrachate_id: @enrachate_user.tira_enrachate_id, user_id: @enrachate_user.user_id }
    end

    assert_redirected_to enrachate_user_path(assigns(:enrachate_user))
  end

  test "should show enrachate_user" do
    get :show, id: @enrachate_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enrachate_user
    assert_response :success
  end

  test "should update enrachate_user" do
    patch :update, id: @enrachate_user, enrachate_user: { answer: @enrachate_user.answer, purchase_date: @enrachate_user.purchase_date, question_enrachate_id: @enrachate_user.question_enrachate_id, status: @enrachate_user.status, tira_enrachate_id: @enrachate_user.tira_enrachate_id, user_id: @enrachate_user.user_id }
    assert_redirected_to enrachate_user_path(assigns(:enrachate_user))
  end

  test "should destroy enrachate_user" do
    assert_difference('EnrachateUser.count', -1) do
      delete :destroy, id: @enrachate_user
    end

    assert_redirected_to enrachate_users_path
  end
end
