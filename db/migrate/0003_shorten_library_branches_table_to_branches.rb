class ShortenLibraryBranchesTableToBranches < ActiveRecord::Migration
  def change
    rename_table :library_branches, :branches
  end
end
