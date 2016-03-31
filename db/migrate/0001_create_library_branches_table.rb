class CreateLibraryBranchesTable < ActiveRecord::Migration
  def change
    create_table :library_branches do |t|
      t.string :branch_name
      t.string :address
      t.integer :phone_number
    end
  end
end
