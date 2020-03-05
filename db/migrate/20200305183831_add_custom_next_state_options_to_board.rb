class AddCustomNextStateOptionsToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :live_to_dead_count, :integer
    add_column :boards, :dead_to_live_count, :integer
  end
end
