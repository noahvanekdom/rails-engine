require 'rails_helper'

describe "Merchant API endpoint" do
  it "can return a single merchant from a requested id" do
    create_list(:merchant, 3)

    get '/api/v1/merchant/'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)

      expect(merchant[:id]).to respond_to(:to_i)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      # expect(merchant[:relationships]).to have_key(:item)
      # expect(merchant[:relationships]).to have_key(:data)
    end
  end
end