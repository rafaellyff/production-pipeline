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

    def validate_batch_orders(group_orders)
		group_orders = group_orders.to_a
		orders = Order.select(:purchase_channel).where('id IN (?)', group_orders)

		if group_orders.length == orders.count && orders.distinct == 1
			return true
		else
			return false
		end
    end
end
