class Batch < ApplicationRecord
    validates :reference, :purchase_channel, :group_orders, presence: true
end
