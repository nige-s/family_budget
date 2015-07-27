class StatementsController < ApplicationController
  before_action  :set_statement, only: [:show, :edit, :update, :destroy]
 
  # GET /statements
  # GET /statements.json
  def index
    @statement = Statement.new(statement_params)
    begin
      @acc_transactions = current_user.accounts.find(@statement.acc_id).transactions.where("tran_date <= ?", @statement.edate).order('tran_date DESC')
      @acc_balance = Statement.account_balance(@statement)
      @balance = @acc_balance[:start_balance] + (@acc_balance[:credits] - @acc_balance[:debits])
    rescue
      flash[:error] = "Not authourised to view the account you attempted to access"
      redirect_to transactions_path 
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = Statement.new
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(statement_params)

    respond_to do |format|
      if @statement.save
        format.html { redirect_to @statement, notice: 'Statement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @statement }
      else
        format.html { render action: 'new' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to @statement, notice: 'Statement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_statement
    @statement = Statement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def statement_params
    params.require(:statement).permit(:acc_id, :edate)
  end
end
