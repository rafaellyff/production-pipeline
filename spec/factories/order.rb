FactoryBot.define do 
    factory :order do
        purchase_channel { %i[site system].sample  }
        client_name { FFaker::Name.name }
        address { FFaker::AddressBR.full_address }
        delivery_service { %i[sedex correios rappi].sample }
        total_value { FFaker::Random.rand(1..999) }
        line_items {"[{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}, {sku: powebank-sunshine, capacity: 10000mah}, {sku: earphone-standard, color: white}]"}
    end
end