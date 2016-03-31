require "active_record"

class LibraryBranch < ActiveRecord::Base
# has three unique attributes: branch name, phone number, and address.
  validates :branch_name, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true

  
end
