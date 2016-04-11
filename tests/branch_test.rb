require "test_helper"

class BranchTest < MiniTest::Test

  def test_can_be_created_normally
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: "4028674178")
    refute_nil(branch)
  end

  def test_format_phone_number_works_properly
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: "989-999-9999")
    branch.format_phone_number
    assert_equal("989-999-9999", branch.phone_number)
    branch.phone_number = "9899999999"
    branch.format_phone_number
    assert_equal("989-999-9999", branch.phone_number)
    branch.phone_number = "19899999999"
    branch.format_phone_number
    assert_equal("989-999-9999", branch.phone_number)
    branch.phone_number = "(989) 999-9999"
    branch.format_phone_number
    assert_equal("989-999-9999", branch.phone_number)
    branch.phone_number = "98999999999"
    branch.format_phone_number
    assert_equal("98999999999", branch.phone_number)
  end

  def test_valid_properly_restricts_character_length
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: "989-999-9999")
    assert(branch.valid?)
    branch.phone_number = "1 989-999-9999"
    assert(branch.valid?)
    branch.phone_number = "989-9999-9999"
    refute(branch.valid?)
    branch.phone_number = "989-99-9999"
    refute(branch.valid?)
  end

  def test_valid_properly_restricts_area_code
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: "009-999-9999")
    refute(branch.valid?)
    branch.phone_number = "109-999-9999"
    refute(branch.valid?)
    branch.phone_number = "209-999-9999"
    assert(branch.valid?)
    branch.phone_number = "200-999-9999"
    refute(branch.valid?)
    branch.phone_number = "290-999-9999"
    assert(branch.valid?)
    branch.phone_number = "299-999-9999"
    refute(branch.valid?)
    branch.phone_number = "911-999-9999"
    refute(branch.valid?)
    branch.phone_number = "915-999-9999"
    assert(branch.valid?)
    branch.phone_number = "955-999-9999"
    refute(branch.valid?)
    branch.phone_number = "951-999-9999"
    assert(branch.valid?)
  end

  def test_valid_properly_restricts_central_office_code
    branch = Branch.new(name:"Lincoln", address:"1000 S 16th St", phone_number: "901-000-9999")
    refute(branch.valid?)
    branch.phone_number = "901-100-9999"
    refute(branch.valid?)
    branch.phone_number = "901-200-9999"
    assert(branch.valid?)
    branch.phone_number = "901-020-9999"
    refute(branch.valid?)
    branch.phone_number = "901-002-9999"
    refute(branch.valid?)
    branch.phone_number = "901-022-9999"
    refute(branch.valid?)
    branch.phone_number = "901-089-9999"
    refute(branch.valid?)
    branch.phone_number = "901-189-9999"
    refute(branch.valid?)
    branch.phone_number = "901-999-9999"
    assert(branch.valid?)
  end




end
