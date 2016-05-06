require 'test_helper'

class QuinielaUsersControllerTest < ActionController::TestCase
  setup do
    @quiniela_user = quiniela_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiniela_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiniela_user" do
    assert_difference('QuinielaUser.count') do
      post :create, quiniela_user: {  }
    end

    assert_redirected_to quiniela_user_path(assigns(:quiniela_user))
  end

  test "should show quiniela_user" do
    get :show, id: @quiniela_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiniela_user
    assert_response :success
  end

  test "should update quiniela_user" do
    patch :update, id: @quiniela_user, quiniela_user: {  }
    assert_redirected_to quiniela_user_path(assigns(:quiniela_user))
  end

  test "should destroy quiniela_user" do
    assert_difference('QuinielaUser.count', -1) do
      delete :destroy, id: @quiniela_user
    end

    assert_redirected_to quiniela_users_path
  end
end
