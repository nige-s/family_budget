require 'test_helper'

class TrantypesControllerTest < ActionController::TestCase
  setup do
    @trantype = trantypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trantypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trantype" do
    assert_difference('Trantype.count') do
      post :create, trantype: { desc: @trantype.desc, name: @trantype.name }
    end

    assert_redirected_to trantype_path(assigns(:trantype))
  end

  test "should show trantype" do
    get :show, id: @trantype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trantype
    assert_response :success
  end

  test "should update trantype" do
    patch :update, id: @trantype, trantype: { desc: @trantype.desc, name: @trantype.name }
    assert_redirected_to trantype_path(assigns(:trantype))
  end

  test "should destroy trantype" do
    assert_difference('Trantype.count', -1) do
      delete :destroy, id: @trantype
    end

    assert_redirected_to trantypes_path
  end
end
