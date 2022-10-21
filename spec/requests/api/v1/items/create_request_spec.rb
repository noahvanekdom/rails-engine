require 'rails_helper'
describe "Create Item api endpoint" do
  before(:each) do
    @merchant = create(:merchant)
    @item_params = {
      name: "Chocolate Milk",
      description: "Yooooohoooo",
      unit_price: 10.00,
      merchant_id: @merchant.id
    }
  end

  it 'can create a successful item' do
    post "/api/v1/items", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item: @item_params)

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    item = Item.last
    expect(item.name).to eq(@item_params[:name])
    expect(item.description).to eq(@item_params[:description])
    expect(item.unit_price).to eq(@item_params[:unit_price])
    expect(item.merchant_id).to eq(@merchant.id)
  end
end
