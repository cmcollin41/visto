class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
    @questions = Question.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @responses = Response.where(report_id: @report)
    @questions = Question.all
  end

  # GET /reports/new
  def new
    @report = current_admin.reports.create
    questions = Question.all
    
    questions.where(active: true).each do |q|
      @report.responses.create(question_id: q.id)
    end

    redirect_to edit_report_path(@report, address: params[:address], customer: params[:customer])
  end

  # GET /reports/1/edit
  def edit
    @questions = Question.all.where(active: true)
    @responses = @report.responses
  end

  # POST /reports
  # POST /reports.json

  def create
    @report = current_admin.reports.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
        redirect_to edit_report_path(@report)
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
        puts @report.errors.full_messages
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:address_id, :customer_id, :admin_id, responses_attributes: [:id, :report_id, :question_id, :choice_id, :response, :_destroy, images: []])
    end
end
