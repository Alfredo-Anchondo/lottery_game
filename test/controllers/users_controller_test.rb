require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address_1: @user.address_1, address_2: @user.address_2, age: @user.age, balance: @user.balance, cellphone: @user.cellphone, city: @user.city, country: @user.country, email: @user.email, ext_number: @user.ext_number, int_number: @user.int_number, last_name: @user.last_name, name: @user.name, password: @user.password, phone: @user.phone, role_id: @user.role_id, state: @user.state, username: @user.username, zip_code: @user.zip_code }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address_1: @user.address_1, address_2: @user.address_2, age: @user.age, balance: @user.balance, cellphone: @user.cellphone, city: @user.city, country: @user.country, email: @user.email, ext_number: @user.ext_number, int_number: @user.int_number, last_name: @user.last_name, name: @user.name, password: @user.password, phone: @user.phone, role_id: @user.role_id, state: @user.state, username: @user.username, zip_code: @user.zip_code }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
