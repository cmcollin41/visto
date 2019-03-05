class PagesController < ApplicationController
  before_action :authenticate_customer!, only: [:profile]

  def index
  	@address = Address.new
  end

  def pricing
  end

  def about
  end
  
  def schedule
  	@address = "kkkk"
  end

  def inspection
  end

  def profile
    @customer = current_customer
    property = @customer.properties.first
    @jobs = @customer.jobs
    @address = Address.find(property.id)
    @reports = @customer.reports
  end

end
