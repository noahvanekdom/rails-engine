require 'rails_helper'

describe "Merchant Items API endpoint" do
  describe "can return all items from a specific merchant from a requested merchant id" do
    before(:each) do
      test_merchant = create(:merchant)
      test_items = create_list(:item, 10, merchant: test_merchant)

      get "/api/v1/merchants/#{test_merchant.id}/items"
    end

    it 'returns items when a valid merchant id is passed in' do
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to have_key(:data)
      expect(body[:data]).to be_a(Array)
      item_list = body[:data]

      item_list.each do |item|
        expect(item).to be_an(Hash)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item).to have_key(:type)
        expect(item[:type]).to eq("item")
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a Hash
        attributes = item[:attributes]

        expect(attributes).to have_key(:name)
        expect(attributes).to have_key(:description)
        expect(attributes[:description]).to be_an(String)
        expect(attributes).to have_key(:unit_price)
        expect(attributes[:unit_price]).to be_an(Float)
      end
    end
  end
end


