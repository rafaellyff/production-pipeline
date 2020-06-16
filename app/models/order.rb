class Order < ApplicationRecord
    validates :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items, presence: true
    validates :reference, uniqueness: true
    validates :total_value, numericality: { greater_than: 0}

    before_create do
        self.status = "ready"
        self.reference = self.generate_reference
    end

    def generate_reference
        reference = "#{Date.today.year}" + ([*('A'..'Z'),*('0'..'9'),*('s'..'z')]).sample(4).join
	    return reference
    end
end
