Rails.configuration.stripe = {
    :stripe_publishable_key => Rails.application.credentials.stripe[:stripe_publishable_key],
    :stripe_secret_key      => Rails.application.credentials.stripe[:stripe_secret_key]
}

Stripe.api_key = Rails.configuration.stripe[:stripe_secret_key]