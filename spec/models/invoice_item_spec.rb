require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "upon being destroyed" do
    it "destroys any associated invoices that are now empty" do
      @item = create(:item)
      @invoice = create(:invoice)
      @invoice_2 = create(:invoice)


      invoiceitem_1 = create(:invoice_item, item: @item, invoice: @invoice)
      invoiceitem_2 = create(:invoice_item, item: @item, invoice: @invoice)

      invoiceitem_3 = create(:invoice_item, item: @item, invoice: @invoice_2)


      expect(Invoice.all.count).to eq 2
      invoiceitem_1.destroy!
      expect(Invoice.all.count).to eq 2
      invoiceitem_3.destroy!
      expect(Invoice.all.count).to eq 1
      invoiceitem_2.destroy
      expect(Invoice.all.count).to eq 0
    end
  end
end
