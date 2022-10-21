require 'rails_helper'

RSpec.describe 'The Items API endpoint' do
  describe "when getting all items" do
    before(:each) do 
      create_list(:item, 20)
    end
    it 'returns an array of items' do
      get '/api/v1/items'

      expect(response).to be_successful
      
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to have_key(:data)

      item_array = body[:data]

      expect(item_array).to be_a(Array)
      expect(item_array.length).to eq 20
    end

    it 'returns attributes about those items' do
      get '/api/v1/items'
      body = JSON.parse(response.body, symbolize_names: true)
      item_array = body[:data]

      item_array.each do |item|
        expect(item).to be_an(Hash)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
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



