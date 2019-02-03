class PagesController < ApplicationController
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

end
