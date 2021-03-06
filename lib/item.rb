class Item
	attr_accessor :id,
	              :name,
							  :description,
						  	:unit_price,
						  	:created_at,
							  :updated_at,
							  :merchant_id

	def initialize(data)
		@id          = data[:id]
		@name        = data[:name]
		@description = data[:description]
		@unit_price  = data[:unit_price]
		@created_at  = data[:created_at]
		@updated_at  = data[:updated_at]
		@merchant_id = data[:merchant_id]
	end

	def unit_price_to_dollars
		@unit_price.truncate(2).to_f
	end

end
