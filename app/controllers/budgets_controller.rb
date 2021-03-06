class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_time_zone

  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = current_user.budgets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @budgets }
    end
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @budget = Budget.find(params[:id])
    @transactions = @budget.transactions.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @budget }
    end
  end

  # GET /budgets/new
  # GET /budgets/new.json
  def new
    @budget = Budget.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budget }
    end
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(params[:budget])
    @budget.users << current_user

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
        format.json { render json: @budget, status: :created, location: @budget }
      else
        format.html { render action: "new" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    @budget = Budget.find(params[:id])

    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end
end
