class AccountsController < ApplicationController
	before_action  :set_account, only: [:show, :edit, :update, :destroy,:statement]

	# GET /accounts
	# GET /accounts.json
	def index
		@accounts = current_user.accounts
	end

	# GET /accounts/1
	# GET /accounts/1.json
	def show
	end
	def statement
	end
	# GET /accounts/new
	def new
		@account = Account.new
	end

	# GET /accounts/1/edit
	def edit
	end

	# POST /accounts
	# POST /accounts.json
	def create
		@account = Account.new(account_params)
		@account.account_holders.build(user_id: current_user.id)

		respond_to do |format|
			if @account.save
				format.html { redirect_to @account, notice: 'Account was successfully created.' }
				format.json { render action: 'show', status: :created, location: @account }
			else
				format.html { render action: 'new' }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /accounts/1
	# PATCH/PUT /accounts/1.json
	def update
		respond_to do |format|
			if @account.update(account_params)
				format.html { redirect_to @account, notice: 'Account was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /accounts/1
	# DELETE /accounts/1.json
	def destroy
		@account.destroy
		respond_to do |format|
			format.html { redirect_to accounts_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_account
		begin
			@account = current_user.accounts.find(params[:id])
		rescue
			flash[:error] = "The account you attempted to access does not belong to you"
			redirect_to accounts_path
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def account_params
		params.require(:account).permit(:name, :starting_balance)
	end
end
