require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
    it { should validate_numericality_of :unit_price }
  end
  describe "relationships" do
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "upon being destroyed" do
    it "destroys any invoice_items that belong to it" do
      destroy_item = create(:item)
      keep_item = create(:item)
      invoiceitem_1 = create(:invoice_item, item: destroy_item)
      invoiceitem_2 = create(:invoice_item, item: keep_item)

      destroy_item.destroy!
      expect(Invoice.all.count).to eq 1
    end
  end
end
