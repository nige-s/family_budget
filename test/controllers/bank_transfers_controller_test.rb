require 'test_helper'

class BankTransfersControllerTest < ActionController::TestCase
  setup do
    @bank_transfer = bank_transfers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_transfers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_transfer" do
    assert_difference('BankTransfer.count') do
      post :create, bank_transfer: { amount: @bank_transfer.amount, description: @bank_transfer.description, src_account_id: @bank_transfer.src_account_id, src_user_id: @bank_transfer.src_user_id, target_account_id: @bank_transfer.target_account_id, target_user_id: @bank_transfer.target_user_id, tran_date: @bank_transfer.tran_date }
    end

    assert_redirected_to bank_transfer_path(assigns(:bank_transfer))
  end

  test "should show bank_transfer" do
    get :show, id: @bank_transfer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_transfer
    assert_response :success
  end

  test "should update bank_transfer" do
    patch :update, id: @bank_transfer, bank_transfer: { amount: @bank_transfer.amount, description: @bank_transfer.description, src_account_id: @bank_transfer.src_account_id, src_user_id: @bank_transfer.src_user_id, target_account_id: @bank_transfer.target_account_id, target_user_id: @bank_transfer.target_user_id, tran_date: @bank_transfer.tran_date }
    assert_redirected_to bank_transfer_path(assigns(:bank_transfer))
  end

  test "should destroy bank_transfer" do
    assert_difference('BankTransfer.count', -1) do
      delete :destroy, id: @bank_transfer
    end

    assert_redirected_to bank_transfers_path
  end
end
