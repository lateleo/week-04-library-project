class CreateBranchIdColumnInBooks < ActiveRecord::Migration
  def change
    add_column :books, :branch_id, :integer
  end
end
