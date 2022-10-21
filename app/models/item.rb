class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  validates_numericality_of :unit_price

  enum status: [:disabled, :enabled]

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

end
