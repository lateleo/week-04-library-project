require "active_record"

class Branch < ActiveRecord::Base
# has three unique attributes: branch name, phone number, and address.
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :phone_number, format: {with: /\A[2-9](\d)(?!\1)\d-[2-9]\d\d-\d{4}\Z/}
  before_validation :format_phone_number_properly

# This is an example method that's a placeholder right now, but may eventually
# be useful in funneling phone number inputs of various formats into integers.
  def format_phone_number_properly
    phone_number.delete!("^0-9")
    phone_number.slice!(0) if (phone_number[0] == "1" && phone_number.length > 10)
    [3,7].each {|n| phone_number.insert(n, "-")}
  end

end
