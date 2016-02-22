require 'test_helper'

class SportCategoriesControllerTest < ActionController::TestCase
  setup do
    @sport_category = sport_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_category" do
    assert_difference('SportCategory.count') do
      post :create, sport_category: { category_id: @sport_category.category_id, sport_id: @sport_category.sport_id }
    end

    assert_redirected_to sport_category_path(assigns(:sport_category))
  end

  test "should show sport_category" do
    get :show, id: @sport_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_category
    assert_response :success
  end

  test "should update sport_category" do
    patch :update, id: @sport_category, sport_category: { category_id: @sport_category.category_id, sport_id: @sport_category.sport_id }
    assert_redirected_to sport_category_path(assigns(:sport_category))
  end

  test "should destroy sport_category" do
    assert_difference('SportCategory.count', -1) do
      delete :destroy, id: @sport_category
    end

    assert_redirected_to sport_categories_path
  end
end
