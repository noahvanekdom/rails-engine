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

  def self.name_search(search, limit = 1)
    result = where("name ILIKE ?", "%#{search}%").limit(limit).order(:name)
  end

  def self.price_search(min_price = nil, max_price = nil, limit)
    if min_price && max_price
      where("unit_price BETWEEN ? AND ?", min_price.to_f, max_price.to_f).limit(limit).order(:name)
    elsif min_price != nil && min_price != ""
      where("unit_price >= ?", min_price).limit(limit).order(:name)
    elsif max_price != nil && max_price != ""
      where("unit_price <= ?", max_price).limit(limit).order(:name)
    end
  end
end
