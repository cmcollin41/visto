class ApplicationController < ActionController::Base
	layout :layout_by_resource

	private

	def layout_by_resource
	  if admin_signed_in?
	    "admin"
	  else
	    "application"
	  end
	end
end
