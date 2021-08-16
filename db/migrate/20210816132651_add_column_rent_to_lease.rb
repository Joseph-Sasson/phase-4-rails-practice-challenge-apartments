class AddColumnRentToLease < ActiveRecord::Migration[6.1]
  def change
    add_column :leases, :rent, :integer
  end
end
