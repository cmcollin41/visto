class AddressesController < ApplicationController
  layout 'squeeze'
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :next_weekdays, only: [:show]
  before_action :available_times, only: [:show]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show

    @customer = Customer.new
    @job = Job.new

    @full_address = @address.long_address
    @lat = @address.latitude
    @long= @address.longitude

    street = @full_address.split(",")[0].strip
    city = @full_address.split(",")[1].strip
    property = Rubillow::PropertyDetails.deep_search_results({ address: street, citystatezip: city })
    sqft = property.lot_size_square_feet
    home_type = property.use_code
    finished_sqft = property.finished_square_feet
    
    @bathrooms = property.bathrooms
    @bedrooms = property.bedrooms
    @yearbuilt = property.year_built

    @hometype = home_type
    @acres = (sqft.to_f / 43560).round(2)
    @sqft = finished_sqft

    if @sqft.to_i > 4000
      cookies[:price] = "499"
    elsif @sqft.to_i > 2300
      cookies[:price] = "359"
    else
      cookies[:price] = "299"
    end
      
  end

  # GET /addresses/new
  def new
    @address = Address.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.create_with(long_address: address_params[:long_address]).where(latitude: address_params[:latitude]).find_or_create_by(
      longitude: address_params[:longitude])

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
        cookies[:address] = @address.id
        cookies[:long_address] = @address.long_address
        cookies[:latitude] = @address.latitude
        cookies[:longitude] = @address.longitude
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.friendly.find(params[:id])
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
    def address_params
      params.require(:address).permit(:name, :long_address, :latitude, :longitude)
    end
end
