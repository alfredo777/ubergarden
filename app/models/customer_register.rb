class CustomerRegister < ApplicationRecord

	def pedidos
		@pedidos = Pedido.where(conekta_customer: self.customer_token_conekta)
	end
end
