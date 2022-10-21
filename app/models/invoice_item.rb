class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price

  belongs_to :invoice
  belongs_to :item

  before_destroy { @invoice = invoice }
  after_destroy { if @invoice.invoice_items.count == 0
                    @invoice.destroy
                  end
                }

  enum status: [:pending, :packaged, :shipped]
end
