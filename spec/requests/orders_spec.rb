require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /orders" do
    it "works! (now write some real specs)" do
      get orders_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /orders/consult_status" do
    it "order fetch parameters are not sent" do
      get "/orders/consult_status/"
      json = JSON.parse(response.body)
      
      expect(response).to have_http_status(400)
      expect(json["message"]).to eq("No search parameters sent")
    end

    it "if reference does not exist" do
      get "/orders/consult_status", :params => { :reference => "12345678" }
      
      expect(response).to have_http_status(200)
      expect(response.body).to eq("[]")
    end
  end

  describe "POST /orders" do
    let(:purchase_channel)  { %i[site system].sample  }
    let(:client_name) { FFaker::Name.name }
    let(:address) { FFaker::AddressBR.full_address }
    let(:delivery_service) { %i[sedex correios rappi].sample }
    let(:total_value) { FFaker::Random.rand(1..999) }
    let(:line_items) { "[{sku: case-my-best-friend, model: iPhone X, case type: Rose Leather}]" }
 
    it "create order" do 
      post "/orders", :params => { 
                        :order => { 
                          :purchase_channel => purchase_channel, 
                          :client_name => client_name,
                          :address => address,
                          :delivery_service => delivery_service,
                          :total_value => total_value,
                          :line_items => line_items
                        } }
      
      json = JSON.parse(response.body)
      
      expect(response).to have_http_status(:created)
      expect(json).to_not be_empty
      expect(json.keys).to contain_exactly("id", "reference","purchase_channel", "client_name", "address", "delivery_service", "total_value", "line_items", "status", "created_at", "updated_at")
      expect(json["reference"].length).to eq(8)
      expect(json["status"]).to eq("ready")
    end

    it "if you do not send mandatory parameters" do
      post "/orders", :params => { 
        :order => { 
          :purchase_channel => purchase_channel, 
          :client_name => client_name,
          :address => address,
          :delivery_service => delivery_service,
          :total_value => total_value,
        } }

      expect(response).to have_http_status(422)
      expect(response.body).to_not be_empty
    end
  end
end
