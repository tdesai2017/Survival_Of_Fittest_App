class AddCurrentAndInitialReviveAndStayAliveCounts < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :initial_revive_count, :text
    add_column :boards, :initial_stay_alive_count, :text
    rename_column :boards, :revive_count, :current_revive_count
    rename_column :boards, :stay_alive_count, :current_stay_alive_count

  end
end
