require 'test_helper'

class QuinielasControllerTest < ActionController::TestCase
  setup do
    @quiniela = quinielas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quinielas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiniela" do
    assert_difference('Quiniela.count') do
      post :create, quiniela: {  }
    end

    assert_redirected_to quiniela_path(assigns(:quiniela))
  end

  test "should show quiniela" do
    get :show, id: @quiniela
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiniela
    assert_response :success
  end

  test "should update quiniela" do
    patch :update, id: @quiniela, quiniela: {  }
    assert_redirected_to quiniela_path(assigns(:quiniela))
  end

  test "should destroy quiniela" do
    assert_difference('Quiniela.count', -1) do
      delete :destroy, id: @quiniela
    end

    assert_redirected_to quinielas_path
  end
end
