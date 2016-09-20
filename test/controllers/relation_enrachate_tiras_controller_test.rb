require 'test_helper'

class RelationEnrachateTirasControllerTest < ActionController::TestCase
  setup do
    @relation_enrachate_tira = relation_enrachate_tiras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relation_enrachate_tiras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relation_enrachate_tira" do
    assert_difference('RelationEnrachateTira.count') do
      post :create, relation_enrachate_tira: { enrachate_id: @relation_enrachate_tira.enrachate_id, tira_enrachate_id: @relation_enrachate_tira.tira_enrachate_id }
    end

    assert_redirected_to relation_enrachate_tira_path(assigns(:relation_enrachate_tira))
  end

  test "should show relation_enrachate_tira" do
    get :show, id: @relation_enrachate_tira
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @relation_enrachate_tira
    assert_response :success
  end

  test "should update relation_enrachate_tira" do
    patch :update, id: @relation_enrachate_tira, relation_enrachate_tira: { enrachate_id: @relation_enrachate_tira.enrachate_id, tira_enrachate_id: @relation_enrachate_tira.tira_enrachate_id }
    assert_redirected_to relation_enrachate_tira_path(assigns(:relation_enrachate_tira))
  end

  test "should destroy relation_enrachate_tira" do
    assert_difference('RelationEnrachateTira.count', -1) do
      delete :destroy, id: @relation_enrachate_tira
    end

    assert_redirected_to relation_enrachate_tiras_path
  end
end
