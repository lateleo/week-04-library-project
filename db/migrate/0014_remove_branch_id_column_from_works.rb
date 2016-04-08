class RemoveBranchIdColumnFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :branch_id, :string
  end
end
