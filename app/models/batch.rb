class Batch < ApplicationRecord
    validates :purchase_channel, :group_orders, presence: true
	validates :reference, uniqueness: true

	before_create do
        self.reference = self.generate_reference
    end

    def generate_reference
        reference = ([*('A'..'Z'),*('0'..'9'),*('s'..'z')]).sample(8).join
	    return reference
    end

	def self.check_batch_orders(group_orders,purchase_channel)
		group_orders = group_orders.to_a
		orders = Order.where(id: group_orders, purchase_channel: purchase_channel).count
		
		if group_orders.length == orders
			return true
		else
			return false
		end
    end
end
