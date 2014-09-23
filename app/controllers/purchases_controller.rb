class PurchasesController < ApplicationController
    def create
      # authorize :purchase, :create?     # version problems
      raise Pundit::NotAuthorizedError unless PurchasePolicy.new(current_user, nil).create?
      # the following only happens if stripe transaction goes through

      Stripe::Charge.create(
        :card        => params[:stripeToken],
        :amount      => 50,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )

      current_user.update_attributes(premium: true)
      redirect_to :back

      # rescue Stripe::CardError => e
      #   flash[:error] = e.message
      #   redirect_to :back
    end
end

# POST /purchases