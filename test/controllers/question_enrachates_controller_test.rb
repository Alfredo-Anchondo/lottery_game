require 'test_helper'

class QuestionEnrachatesControllerTest < ActionController::TestCase
  setup do
    @question_enrachate = question_enrachates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_enrachates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_enrachate" do
    assert_difference('QuestionEnrachate.count') do
      post :create, question_enrachate: { answer1: @question_enrachate.answer1, answer2: @question_enrachate.answer2, program_date: @question_enrachate.program_date, title: @question_enrachate.title }
    end

    assert_redirected_to question_enrachate_path(assigns(:question_enrachate))
  end

  test "should show question_enrachate" do
    get :show, id: @question_enrachate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_enrachate
    assert_response :success
  end

  test "should update question_enrachate" do
    patch :update, id: @question_enrachate, question_enrachate: { answer1: @question_enrachate.answer1, answer2: @question_enrachate.answer2, program_date: @question_enrachate.program_date, title: @question_enrachate.title }
    assert_redirected_to question_enrachate_path(assigns(:question_enrachate))
  end

  test "should destroy question_enrachate" do
    assert_difference('QuestionEnrachate.count', -1) do
      delete :destroy, id: @question_enrachate
    end

    assert_redirected_to question_enrachates_path
  end
end
