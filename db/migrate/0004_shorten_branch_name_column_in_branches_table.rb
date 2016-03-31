class ShortenBranchNameColumnInBranchesTable < ActiveRecord::Migration
  def change
    rename_column :branches, :branch_name, :name
  end
end
