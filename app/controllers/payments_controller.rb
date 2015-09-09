# class PaymentsController < AdminController
#
#   before_filter :load_order
#
#   def create
#     @payment = Payment.new(payment_params)
#     @payment.paid = false
#     @payment.order = @order
#   end
#
#   private
#   def payment_params
#     params.require(:payment).permit(:sent, :received, :paid, :payment_method)
#   end
# end