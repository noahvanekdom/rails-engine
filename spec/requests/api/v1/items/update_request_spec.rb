require 'rails_helper'

describe "Update Item api endpoint" do
  before(:each) do
    @merchant = create(:merchant)
    @item_params = {
      name: "Chocolate Milk",
      description: "Yooooohoooo",
      unit_price: 10.00
    }
  end

  it "can update an existing item" do
    item = create(:item)
    id = item.id
    previous_name = Item.last.name
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: @item_params})
    item_new = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item_new.name).to_not eq(previous_name)
    expect(item_new.name).to eq("Chocolate Milk")
  end

  it "only updates with valid attributes" do
    invalid_item_params = @item_params = {
      name: "Chocolate Milk",
      description: "Yooooohoooo",
      unit_price: 10.00,
      merchant_id:  999999999999
    }
    item = create(:item, merchant: @merchant)
    id = item.id
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: invalid_item_params})

    expect(response.status).to eq 400
    ##add valid expect statement here
  end
end
