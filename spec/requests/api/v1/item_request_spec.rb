require 'rails_helper'

describe "Single Item API endpoint" do
  it "can return a single item from a requested id" do
    test_item = create(:item)
    get "/api/v1/items/#{test_item.id}"

    expect(response).to be_successful
    api_response = JSON.parse(response.body, symbolize_names: true)

    expect(api_response).to have_key(:data)
    expect(api_response[:data]).to be_an(Hash)

    item = api_response[:data]
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)
    expect(item).to have_key(:type)
    expect(item[:type]).to eq("item")
    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_an(Hash)
    item_attributes = item[:attributes]
    expect(item_attributes).to have_key(:name)
    expect(item_attributes[:name]).to be_an(String)
  end
end