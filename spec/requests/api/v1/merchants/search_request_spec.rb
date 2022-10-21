require 'rails_helper'

describe "Merchant search endpoint" do
  before(:each) do
    @merchant = create(:merchant, name: "BLAINE")
    @merchant_2 = create(:merchant, name: "blazzblahblah")
    @merchant_3 = create(:merchant, name: "Willy Wonka")
  end
  it 'returns an item based on a search query' do
    get "/api/v1/merchants/find_all?name=BLAINE"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to be_an(Hash)
    expect(body).to have_key(:data)
    merchants_data = body[:data]

    expect(merchants_data).to be_an(Array)
    expect(merchants_data.count).to eq 1
    expect(merchants_data.first[:id]).to eq(@merchant.id.to_s)
    blaine_merchant_data = merchants_data.first
    expect(blaine_merchant_data).to have_key(:type)
    expect(blaine_merchant_data[:type]).to eq "merchant"
    expect(blaine_merchant_data).to have_key(:attributes)
    expect(blaine_merchant_data[:attributes]).to be_an(Hash)
    merchant_attributes = blaine_merchant_data[:attributes]
    expect(merchant_attributes[:name]).to eq(@merchant.name)
  end

  it 'can return partial matches case insensitive' do

    get "/api/v1/merchants/find_all?name=bla"

    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to be_a(Array)
    expect(body[:data].count).to eq(2)
  end

  it 'errors when inputs are invalid' do
    get "/api/v1/merchants/find_all?name="
    expect(response.status).to eq 400

    get "/api/v1/merchants/find_all?"
    expect(response.status).to eq 400
  end

  it 'returns an empty array when no matches are found' do
    get "/api/v1/merchants/find_all?name=nonsenseenglish"
    expect(response.status).to eq 404
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to eq({:data=>[]})
  end
end