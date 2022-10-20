require 'rails_helper'

describe "Merchant API endpoint" do
  it "can return a single merchant from a requested id" do
    test_merchant = create(:merchant)
    get "/api/v1/merchants/#{test_merchant.id}"

    expect(response).to be_successful
    api_response = JSON.parse(response.body, symbolize_names: true)

    expect(api_response).to have_key(:data)
    expect(api_response[:data]).to be_an(Hash)

    merchant = api_response[:data]
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant")
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)
    merchant_attributes = merchant[:attributes]
    expect(merchant_attributes).to have_key(:name)
    expect(merchant_attributes[:name]).to be_an(String)
  end

  xit 'returns an error when the id does not match an id of a merchant in the system' do


    get "/api/v1/merchants/1"

    expect(response).to have_http_status(404)
  end
end