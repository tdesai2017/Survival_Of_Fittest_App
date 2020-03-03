class AddGenerationToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :generation, :integer
  end
end
