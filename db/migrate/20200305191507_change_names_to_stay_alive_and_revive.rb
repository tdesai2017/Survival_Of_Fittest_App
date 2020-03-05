class ChangeNamesToStayAliveAndRevive < ActiveRecord::Migration[6.0]
  def change
    rename_column :boards, :alive_to_dead_count, :stay_alive_count
    rename_column :boards, :dead_to_alive_count, :revive_count
  end
end

