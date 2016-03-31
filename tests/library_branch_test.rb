require "test_helper"
require_relative "../lib/library_branch.rb"

class LibraryBranchTest < MiniTest::Test

  def test_can_be_created_normally
    branch = LibraryBranch.new(branch_name:"Lincoln", address:"1000 S 16th St", phone_number: 4028674178)
    refute_nil(branch)
  end

  def test_phone_number_valid_only_accepts_correct_digits
    branch = LibraryBranch.new(branch_name:"Lincoln", address:"1000 S 16th St", phone_number: 4028674178)
    assert(phone_number_valid?)
    phone_number = 40286741780
    refute(phone_number_valid?)
    phone_number = 402867417
    refute(phone_number_valid?)
  end

  def test_phone_number_valid_properly_enforces_digit_rules
    branch = LibraryBranch.new(branch_name:"Lincoln", address:"1000 S 16th St", phone_number: 1028674178)
    refute(phone_number_valid?)
    phone_number = 4008674178
    refute(phone_number_valid?)
    phone_number = 4118674178
    refute(phone_number_valid?)
    phone_number = 4228674178
  end

end
