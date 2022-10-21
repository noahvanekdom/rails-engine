require 'rails_helper'

describe "Item search" do

  describe "Find one" do
    before(:each) do
      @merchant = create(:merchant)
      @item = create(:item, name: "BLAINE", unit_price: 1000.00)
      @item_2 = create(:item, name: "Chocolate Milk", unit_price: 15.00)
      @item_3 = create(:item, name: "Tiger", unit_price: 430.50)
      @item_4 = create(:item, name: "Albatross Saddles", unit_price: 500.00, merchant_id: @merchant.id)
    end
    it 'returns an item based on a search query' do
      get "/api/v1/items/find?name=BLAINE"

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to be_an(Hash)
      expect(body).to have_key(:data)
      item_data = body[:data]
      # expect(item_data[:id]).to respond_to(:to_i)
      expect(item_data[:id]).to eq(@item.id.to_s)
      expect(item_data).to have_key(:type)
      expect(item_data[:type]).to eq "item"
      expect(item_data).to have_key(:attributes)
      expect(item_data[:attributes]).to be_an(Hash)
      item_attributes = item_data[:attributes]
      expect(item_attributes[:name]).to eq(@item.name)
      expect(item_attributes[:description]).to eq(@item.description)
      expect(item_attributes[:unit_price]).to eq(@item.unit_price)
    end

    it 'can return partial search results and handle capital letters' do
      get "/api/v1/items/find?name=blai"
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_an(Hash)
      expect(body).to have_key(:data)
      item_data = body[:data]
      # expect(item_data[:id]).to respond_to(:to_i)
      expect(item_data[:id]).to eq(@item.id.to_s)
      expect(item_data).to have_key(:type)
      expect(item_data[:type]).to eq "item"
      expect(item_data).to have_key(:attributes)
      expect(item_data[:attributes]).to be_an(Hash)
      item_attributes = item_data[:attributes]
      expect(item_attributes[:name]).to eq(@item.name)
      expect(item_attributes[:description]).to eq(@item.description)
      expect(item_attributes[:unit_price]).to eq(@item.unit_price)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body)
    end

    it 'errors upon a nil input' do
      get "/api/v1/items/find?name="
      expect(response.status).to eq 400
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to eq({
        :attributes => [],
        :error => "bad inputs",
        :id => nil,
        :message => "your query could not be completed"
          })
    end

    it 'returns an empty object if there are no results' do
      get "/api/v1/items/find?name=xjfeisp"
      # require 'pry'; binding.pry
      # expect(response.status).to eq 204

      body = JSON.parse(response.body, symbolize_names: true )

      expect(body).to eq({data:{}})
    end

    describe "find one by price happy paths" do

      it 'returns a search by min and max price' do
        get "/api/v1/items/find?min_price=100&max_price=2000"
        expected_response = {:data=>{:attributes=>{:description=>@item_4.description, :merchant_id=>@merchant.id, :name=>"Albatross Saddles", :unit_price=>500.0}, :id=>@item_4.id.to_s, :type=>"item"}}

        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true )
        expect(body).to eq expected_response
      end

      it 'errors if the min or max price is less than 0' do
        get "/api/v1/items/find?max_price=-100"
        expect(response.status).to eq 400
        get "/api/v1/items/find?min_price=-1"
        expect(response.status).to eq 400
      end

      it 'errors if the min price is below the max price' do
        get "/api/v1/items/find?min_price=50&max_price=10"
        expect(response.status).to eq 400
      end

      it 'errors on a nil input' do
        get "/api/v1/items/find?min_price="
        expect(response.status).to eq 400
      end

      it 'returns an empty object if a max price is set below all unit_prices' do
        get "/api/v1/items/find?max_price=5"
        body = JSON.parse(response.body, symbolize_names: true )
        expect(body).to eq({data:{}})
      end
    end
  end
end