require 'rails_helper'
describe "Destroy Item api endpoint" do
  before(:each) do
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
  end

  it "destroys an item with a given id" do

    expect{ delete "/api/v1/items/#{@item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(@item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end






