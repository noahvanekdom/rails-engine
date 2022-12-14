class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :bulk_discounts
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.name_search(search)
    result = where("name ILIKE ?", "%#{search}%").order(:name)
  end
end
