class AddPositionToRoutes < ActiveRecord::Migration[5.0]
  def change
    add_column :routes, :position, :integer

    Journey.all.each do |journey|
	  journey.routes.order(:updated_at).each.with_index(1) do |route, index|
	    route.update_column :position, index
	  end
	end
  end
end
