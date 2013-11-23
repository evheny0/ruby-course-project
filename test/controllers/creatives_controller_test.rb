require 'test_helper'

class CreativesControllerTest < ActionController::TestCase
  setup do
    @creative = creatives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:creatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creative" do
    assert_difference('Creative.count') do
      post :create, creative: { chapters_id: @creative.chapters_id, description: @creative.description, tags_id: @creative.tags_id, title: @creative.title, user_id: @creative.user_id, votes: @creative.votes }
    end

    assert_redirected_to creative_path(assigns(:creative))
  end

  test "should show creative" do
    get :show, id: @creative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creative
    assert_response :success
  end

  test "should update creative" do
    patch :update, id: @creative, creative: { chapters_id: @creative.chapters_id, description: @creative.description, tags_id: @creative.tags_id, title: @creative.title, user_id: @creative.user_id, votes: @creative.votes }
    assert_redirected_to creative_path(assigns(:creative))
  end

  test "should destroy creative" do
    assert_difference('Creative.count', -1) do
      delete :destroy, id: @creative
    end

    assert_redirected_to creatives_path
  end
end
