require "test_helper"
require_relative "../lib/staff_member.rb"

class StaffMemberTest < MiniTest::Test
  def test_can_be_created_normally
    staff = StaffMember.new(name:"Art Burtch", email:"artburtch13@hotmail.com")
    refute_nil(staff)
  end

  def test_valid
    staff = StaffMember.new(name:"Art Burtch", email:"artburtch13@hotmail.com")
    assert(staff.valid?)
  end



end
