class PaymentsController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_customer!

def customer
   customer = if current_customer.stripe_id?
               	Stripe::Customer.retrieve(current_customer.stripe_id)
             else
               	Stripe::Customer.create({
								    source: params[:stripeToken],
								    email: current_customer.email
								})
             end


    options = {
      stripe_id: customer.id,
    }

    # Only update the card on file if we're adding a new one
    options.merge!(
      card_last4: params[:card_last4],
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_type: params[:card_brand]

    ) if params[:card_last4]

    if current_customer.update(options)
      current_customer.save
			redirect_to edit_customer_registration_path, notice: "Your payment info has been saved."
		else
			redirect_to root_path, notice: "Hmmm, something went wrong."
		end


end

def charge

end



end