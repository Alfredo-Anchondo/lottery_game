require 'test_helper'

class TiraEnrachatesControllerTest < ActionController::TestCase
  setup do
    @tira_enrachate = tira_enrachates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tira_enrachates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tira_enrachate" do
    assert_difference('TiraEnrachate.count') do
      post :create, tira_enrachate: { name: @tira_enrachate.name, program_date: @tira_enrachate.program_date }
    end

    assert_redirected_to tira_enrachate_path(assigns(:tira_enrachate))
  end

  test "should show tira_enrachate" do
    get :show, id: @tira_enrachate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tira_enrachate
    assert_response :success
  end

  test "should update tira_enrachate" do
    patch :update, id: @tira_enrachate, tira_enrachate: { name: @tira_enrachate.name, program_date: @tira_enrachate.program_date }
    assert_redirected_to tira_enrachate_path(assigns(:tira_enrachate))
  end

  test "should destroy tira_enrachate" do
    assert_difference('TiraEnrachate.count', -1) do
      delete :destroy, id: @tira_enrachate
    end

    assert_redirected_to tira_enrachates_path
  end
end
