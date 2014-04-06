require 'test_helper'

class RecurringTransactionsControllerTest < ActionController::TestCase
  setup do
    @recurring_transaction = recurring_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_transaction" do
    assert_difference('RecurringTransaction.count') do
      post :create, recurring_transaction: { account_id: @recurring_transaction.account_id, active: @recurring_transaction.active, amount: @recurring_transaction.amount, day: @recurring_transaction.day, description: @recurring_transaction.description, end_date: @recurring_transaction.end_date, interval: @recurring_transaction.interval, last_updated: @recurring_transaction.last_updated, sign: @recurring_transaction.sign, start_date: @recurring_transaction.start_date }
    end

    assert_redirected_to recurring_transaction_path(assigns(:recurring_transaction))
  end

  test "should show recurring_transaction" do
    get :show, id: @recurring_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_transaction
    assert_response :success
  end

  test "should update recurring_transaction" do
    patch :update, id: @recurring_transaction, recurring_transaction: { account_id: @recurring_transaction.account_id, active: @recurring_transaction.active, amount: @recurring_transaction.amount, day: @recurring_transaction.day, description: @recurring_transaction.description, end_date: @recurring_transaction.end_date, interval: @recurring_transaction.interval, last_updated: @recurring_transaction.last_updated, sign: @recurring_transaction.sign, start_date: @recurring_transaction.start_date }
    assert_redirected_to recurring_transaction_path(assigns(:recurring_transaction))
  end

  test "should destroy recurring_transaction" do
    assert_difference('RecurringTransaction.count', -1) do
      delete :destroy, id: @recurring_transaction
    end

    assert_redirected_to recurring_transactions_path
  end
end
