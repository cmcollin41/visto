class JobsController < ApplicationController
  layout "squeeze", only: [:new]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :next_weekdays, only: [:new, :edit]
  before_action :available_times, only: [:new, :edit]
  before_action :authenticate_customer!, only: [:new]
  before_action :authenticate_admin!, except: [:new, :create]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new

    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to profile_path, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
         cookies[:job] = @job.id
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def next_weekdays
      week = Date.today..6.days.from_now
      @days = week.select { |day| day.strftime("%a") != "Sun" }
    end

    def available_times
      times = []
      for hour in 8..18 do
        d = DateTime.new(2019, 1, 1, hour, 0, 0)
        times << d  
      end
      @times = times
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:price, :time, :date, :address_id, :customer_id)
    end
end
