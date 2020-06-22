# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 0..5
    Order.create(
        purchase_channel: "Site BR",
        client_name: FFaker::Name.name,
        address: FFaker::AddressBR.full_address,
        delivery_service: %i[sedex correios rappi].sample,
        total_value: FFaker::Random.rand(50..999),
        line_items: "[{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}, {sku: powebank-sunshine, capacity: 10000mah}, {sku: earphone-standard, color: white}]"
    )

    Order.create(
        purchase_channel: "Site NL",
        client_name: FFaker::Name.name,
        address: "#{FFaker::AddressNL.street_name}, #{FFaker::AddressNL.postal_code}, #{FFaker::AddressNL.city} " ,
        delivery_service: %i[sedex correios rappi].sample,
        total_value: FFaker::Random.rand(50..999),
        line_items: "[{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}, {sku: powebank-sunshine, capacity: 10000mah}]"
    )
end

orders = Order.select(:id).where(purchase_channel: "Site BR", delivery_service: "sedex").limit(3)

ids = Array.new
orders.each do |order|
    ids.push(order.id)
end

Batch.create(purchase_channel: "Site BR", group_orders: ids)

