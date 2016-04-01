class CreateBranchIdColumnInStaffMembers < ActiveRecord::Migration
  def change
    add_column :staff_members, :branch_id, :integer
  end
end
