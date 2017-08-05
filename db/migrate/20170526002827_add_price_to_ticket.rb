class AddPriceToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :price, :float
  end
end
