class ChangePhoneNumberColumnToStringInLibraryBranches < ActiveRecord::Migration
  def change
    change_column :library_branches, :phone_number, :string
  end
end
