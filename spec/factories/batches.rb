FactoryBot.define do
  factory :batch do
    purchase_channel { %i[site system].sample  }
    group_orders { []}
  end
end
