require "test_helper"
require_relative "../lib/branch.rb"

class BranchTest < MiniTest::Test

  def test_can_be_created_normally
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: 4028674178)
    refute_nil(branch)
  end

end
