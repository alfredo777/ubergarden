class Pedido < ApplicationRecord
	has_many :productos_a_pedidos
	scope :codigo, lambda { |codigo| where(["nombre LIKE ?", "#{codigo}"])}
	scope :conekta_order, lambda { |conekta_order| where(["nombre LIKE ?", "#{conekta_order}"])}
	scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }

	def status
		if self.conekta_order.nil?
		order = nil
		else
		order = Conekta::Order.find(self.conekta_order)
	    end
		#order.payment_status
		order
	end

	def self.to_csv(options = {})
	    CSV.generate(options) do |csv|
	      csv << column_names
	      all.each do |product|
	        csv << product.attributes.values_at(*column_names)
	      end
	    end
  end
end
