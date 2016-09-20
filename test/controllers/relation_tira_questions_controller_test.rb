require 'test_helper'

class RelationTiraQuestionsControllerTest < ActionController::TestCase
  setup do
    @relation_tira_question = relation_tira_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relation_tira_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relation_tira_question" do
    assert_difference('RelationTiraQuestion.count') do
      post :create, relation_tira_question: { question_enrachate_id: @relation_tira_question.question_enrachate_id, tira_enrachate_id: @relation_tira_question.tira_enrachate_id }
    end

    assert_redirected_to relation_tira_question_path(assigns(:relation_tira_question))
  end

  test "should show relation_tira_question" do
    get :show, id: @relation_tira_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @relation_tira_question
    assert_response :success
  end

  test "should update relation_tira_question" do
    patch :update, id: @relation_tira_question, relation_tira_question: { question_enrachate_id: @relation_tira_question.question_enrachate_id, tira_enrachate_id: @relation_tira_question.tira_enrachate_id }
    assert_redirected_to relation_tira_question_path(assigns(:relation_tira_question))
  end

  test "should destroy relation_tira_question" do
    assert_difference('RelationTiraQuestion.count', -1) do
      delete :destroy, id: @relation_tira_question
    end

    assert_redirected_to relation_tira_questions_path
  end
end
