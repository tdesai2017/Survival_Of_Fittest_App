class MakeBoardContentText2 < ActiveRecord::Migration[6.0]
  def change
    change_column :boards, :content, :text
  end
end
