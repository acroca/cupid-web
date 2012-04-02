require 'test_helper'

class PretendersControllerTest < ActionController::TestCase
  setup do
    @pretender = pretenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pretenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pretender" do
    assert_difference('Pretender.count') do
      post :create, pretender: { name: @pretender.name }
    end

    assert_redirected_to pretender_path(assigns(:pretender))
  end

  test "should show pretender" do
    get :show, id: @pretender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pretender
    assert_response :success
  end

  test "should update pretender" do
    put :update, id: @pretender, pretender: { name: @pretender.name }
    assert_redirected_to pretender_path(assigns(:pretender))
  end

  test "should destroy pretender" do
    assert_difference('Pretender.count', -1) do
      delete :destroy, id: @pretender
    end

    assert_redirected_to pretenders_path
  end
end
