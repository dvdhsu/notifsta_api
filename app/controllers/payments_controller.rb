class PaymentsController < ApplicationController
  def create
    @amount = 10000
    puts params

    customer = Stripe::Customer.create(
      :email => params[:user_email],
      :card  => params[:stripe_token],
    )


    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "#{params[:email]}, $100, Notifsta",
      :currency    => 'usd'
    )

    puts charge

    render json: { status: "success" }

  rescue Stripe::CardError => e
      render json: { status: "failure", message: e }
  end
end
