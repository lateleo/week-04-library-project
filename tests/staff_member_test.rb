require "test_helper"
require_relative "../lib/staff_member.rb"

class StaffMemberTest < MiniTest::Test
  def test_can_be_created_normally
    staff = StaffMember.new(name:"Art Burtch", email:"artburtch13@hotmail.com")
    refute_nil(staff)
  end

  def test_valid_accepts_correctly
    staff = StaffMember.new(name:"Art Burtch", email:"artburtch13@hotmail.com")
    assert(staff.valid?)
  end

  def test_valid_rejects_no_name
    staff = StaffMember.new(name:nil, email:"13@hotmail.com")
    refute(staff.valid?)
  end

  def test_valid_requires_name_in_email
    staff = StaffMember.new(name:"Art Burtch", email:"aburtch13@hotmail.com")
    refute(staff.valid?)
  end

  def test_valid_requires_1_to_4_digits_in_email
    staff = StaffMember.new(name:"Art Burtch", email:"artburtch@hotmail.com")
    refute(staff.valid?)
    staff.email = "artburtch1@hotmail.com"
    assert(staff.valid?)
    staff.email = "artburtch2113@hotmail.com"
    assert(staff.valid?)
    staff.email = "artburtch82291@hotmail.com"
    refute(staff.valid?)
  end



end
