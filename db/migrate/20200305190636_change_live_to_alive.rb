class ChangeLiveToAlive < ActiveRecord::Migration[6.0]
  def change
    rename_column :boards, :live_to_dead_count, :alive_to_dead_count
    rename_column :boards, :dead_to_live_count, :dead_to_alive_count
  end
end
