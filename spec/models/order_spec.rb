require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should validate_uniqueness_of(:reference) }

  describe "presence validations" do
    it { should validate_presence_of(:purchase_channel) }
    it { should validate_presence_of(:client_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:delivery_service) }
    it { should validate_presence_of(:total_value) }
    it { should validate_presence_of(:line_items) }
  end

  it "is invalid if total_value is not greater than zero" do 
    order = build(:order, total_value: FFaker::Random.rand(-999..-1) )
    expect(order).to_not be_valid
  end
  
  it 'status is downcase' do
    order = create(:order, status: "Ready")
    expect(order.status).to eql("ready")
  end

  it 'delivery service is downcase' do
    order = create(:order, delivery_service: "SEDEX")
    expect(order.delivery_service).to eql("sedex")
  end

end
