class ChangeCountsFromIntegerToText < ActiveRecord::Migration[6.0]
  def change
    change_column :boards, :live_to_dead_count, :text
    change_column :boards, :dead_to_live_count, :text
  end
end
