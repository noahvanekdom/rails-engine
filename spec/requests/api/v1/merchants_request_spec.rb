require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)

      expect(merchant[:id]).to respond_to(:to_i)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:relationships]).to have_key(:item)
      expect(merchant[:relationships]).to have_key(:data)
    end
  end

end