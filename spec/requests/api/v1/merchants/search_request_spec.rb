require 'rails_helper'

describe "Merchant search endpoint" do
  it 'returns an item based on a search query' do
    item = create(:item, name: "BLAINE")

    get "/api/v1/items/find?name=BLAINE"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to be_an(Hash)
    expect(body).to have_key(:data)
    item_data = body[:data]
    expect(item_data[:id]).to respond_to(:to_i)
    expect(item_data[:id]).to eq(item.id)
    expect(item_data).to have_key(:type)
    expect(item_data[:type]).to eq "item"
    expect(item_data).to have_key(:attributes)
    expect(item_data[:attributes]).to be_an(Hash)
    item_attributes = item_data[:attributes]
    expect(item_attributes[:name]).to eq(item.name)
    expect(item_attributes[:description]).to eq(item.description)
    expect(item_attributes[:unit_price]).to eq(item.unit_price)
  end
end