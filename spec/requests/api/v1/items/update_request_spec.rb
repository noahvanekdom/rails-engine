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

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: @item_params})
    item_new = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item_new.name).to_not eq(previous_name)
    expect(item_new.name).to eq("Chocolate Milk")
  end
end
