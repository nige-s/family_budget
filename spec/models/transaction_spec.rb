require 'spec_helper'

describe Transaction do

  context "with valid required values" do

    let!(:trans) { Transaction.new(user_id: 1, category_id: 1, account_id:1, amount: 50, sign: 'debit') }

    it "is valid" do
      trans.should be_valid    
    end

    it "is invalid without user_id" do
      trans.user_id = nil
      trans.category_id = nil
      trans.account_id = nil
      trans.amount = nil
      trans.sign = nil

      trans.should_not be_valid
      trans.errors.should have_key(:category_id);
      trans.errors.should have_key(:user_id);
      trans.errors.should have_key(:account_id);
      trans.errors.should have_key(:amount);
      trans.errors.should have_key(:sign);
    end
  end
end

