class Order < ApplicationRecord
    validates :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items, presence: true
    validates :reference, uniqueness: true
    validates :total_value, numericality: { greater_than: 0}

    scope :filter_by_client_name, -> (client_name) { where("lower(client_name) like ?", "#{client_name.downcase}%")}
    scope :filter_by_reference, -> (reference) { where reference: reference }
    scope :filter_by_purchase_channel, -> (purchase_channel) { where purchase_channel: purchase_channel }  
    scope :filter_by_status, -> (status) { where status: status }  


    before_save do
        self.status = status.downcase
    end
    
    before_create do
        self.status = "ready"
        self.reference = self.generate_reference
    end

    def generate_reference
        reference = ([*('A'..'Z'),*('0'..'9'),*('s'..'z')]).sample(8).join
	    return reference
    end

    def update_status_by_batch(group_orders, status)
        orders = group_orders.to_a
        Order.where('id IN (?)', group_orders).update_all(status: status, updated_at: Time.zone.now)
    end
end
