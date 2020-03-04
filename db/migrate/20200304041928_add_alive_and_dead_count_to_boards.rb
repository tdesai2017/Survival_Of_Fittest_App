class AddAliveAndDeadCountToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :alive_count, :integer
    add_column :boards, :dead_count, :integer

  end
end
