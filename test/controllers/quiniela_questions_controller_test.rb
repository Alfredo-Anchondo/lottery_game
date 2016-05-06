require 'test_helper'

class QuinielaQuestionsControllerTest < ActionController::TestCase
  setup do
    @quiniela_question = quiniela_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiniela_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiniela_question" do
    assert_difference('QuinielaQuestion.count') do
      post :create, quiniela_question: {  }
    end

    assert_redirected_to quiniela_question_path(assigns(:quiniela_question))
  end

  test "should show quiniela_question" do
    get :show, id: @quiniela_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiniela_question
    assert_response :success
  end

  test "should update quiniela_question" do
    patch :update, id: @quiniela_question, quiniela_question: {  }
    assert_redirected_to quiniela_question_path(assigns(:quiniela_question))
  end

  test "should destroy quiniela_question" do
    assert_difference('QuinielaQuestion.count', -1) do
      delete :destroy, id: @quiniela_question
    end

    assert_redirected_to quiniela_questions_path
  end
end
