class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_report, only: [:show, :edit, :update, :destroy, :form, :info]
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
    @responses = @report.responses
    @questions = Question.where(active: true).includes(:choices).includes(:responses)
  end

  def info
    #include params to filter the data
    @questions = Question.where("system = ?", params[:question]).order(id: :asc).includes(:responses).where(responses: {report_id: @report.id}).order(id: :asc)
    @responses = @report.responses
    @score = Response.sum(:observation)
    @t_score = (Response.count * 5)
    render partial: 'info', locals: {report: @report, questions: @questions, responses: @responses}, layout: false
  end

  # GET /reports/new
  def new
    @report = current_admin.reports.create(address_id: params[:address], customer_id: params[:customer])
    questions = Question.where(active: true).order(id: :asc)
    
    questions.each do |q|
      @report.responses.create(question_id: q.id)
    end

    redirect_to edit_report_path(@report)
  end

  # GET /reports/1/edit
  def edit
    @address = Address.find(@report.address_id).long_address
    @customer = Customer.find(@report.customer_id).name
    @questions = Question.includes(:responses).where(responses: {report_id: @report.id}).order(id: :asc).group_by(&:system).values.sort
    @responses = @report.responses.includes(:question) 

    respond_to do |format|
      format.html
    end
  end

  def form
    #include params to filter the data

    @questions = Question.where("system = ?", params[:question]).order(id: :asc).includes(:responses).where(responses: {report_id: @report.id}).order(id: :asc)
    @responses = @report.responses.includes(:question)   
    render partial: 'form', locals: {report: @report, questions: @questions, responses: @responses}, layout: false
  end

  def images
    @question = Question.find(params[:question])
    @response = @question.responses.first
    render partial: 'images', locals:{response: @response, r: params[:r]}, layout: false
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

  def delete_image   
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:address_id, :customer_id, :admin_id, :cover, 
        responses_attributes: [:id, :report_id, :question_id, :choice_id, :response, :observation, :_destroy, images: [],
        items_attributes: [:id, :number, :size, :fuel_type, :notes, :_destroy]])
    end
end
