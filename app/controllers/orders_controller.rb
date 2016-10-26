class OrdersController < ApplicationController
	before_action :set_ticket, only: [ :create ]

	def create
		create_order
		unless current_user.customer_id
			create_stripe_customer
		end
		charge_customer
		update_customer_tickets
		update_order_status
		flash[:notice] = "Votre paiement a bien fonctionné et #{@order.tickets_nb} ont été rajoutés à votre compte"
	  redirect_to(:back)
	  rescue Stripe::CardError => e
		  flash[:error] = "Votre paiement n'a pas fonctionné, merci de réessayer"
		  redirect_to(:back)
	end

	private

	def set_ticket
		@tickets_package = TicketsPackage.find(params[:tickets_package_id])
	end

	def create_order
	  @order = Order.new
	  @order.ticket_sku = @tickets_package.sku
	  @order.tickets_nb = @tickets_package.tickets_nb
	  @order.amount = @tickets_package.price
	  @order.user = current_user
	  @order.state = 'pending'
	  authorize @order
	  @order.save!
	end

	def create_stripe_customer
		@customer = Stripe::Customer.create(
	    source: params[:stripeToken],
	    email:  params[:stripeEmail]
	  )
	  current_user.customer_id = @customer.id
	end

	def charge_customer
	  @charge = Stripe::Charge.create(
	    customer:     current_user.customer_id,   # You should store this customer id and re-use it.
	    amount:       @order.amount_cents, # or amount_pennies
	    description:  "Paiement pour #{@order.tickets_nb} #{@order.ticket_sku} pour la commande #{@order.id}",
	    currency:     @order.amount.currency
	  )
	end

	def update_customer_tickets
		current_user.tickets_nb += 10
		current_user.save
	end

	def update_order_status
		@order.update(payment: @charge.to_json, state: 'paid')
	end
end
