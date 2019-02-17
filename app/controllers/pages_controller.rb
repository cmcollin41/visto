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
    @job = @customer.jobs.first
    @address = Address.find(property.id)
  end

end
