class AddInitalStateToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :initial_state, :text
    rename_column :boards, :content, :current_state
  end
end
