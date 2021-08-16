class Apartment < ApplicationRecord
  has_many :leases
  has_many :tenants, through: :leases
  validates :number, numericality: { only_integer: true }
end
