require "active_record"

class LibraryBranch < ActiveRecord::Base
# has three unique attributes: branch name, phone number, and address.
  validates :branch_name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates :phone_number, format: { with: /\A[2-9](\d)(?!\1)\d[2-9]\d{6}\Z/}

# This is an example method that's a placeholder right now, but may eventually
# be useful in funneling phone number inputs of various formats into integers.
  def format_phone_number_properly(phone_number)
    #fill this in later
  end

# Custom validator for phone number, because of the weird restrictions on which
# digits are valid where.
  def phone_number_valid?(phone_number)
    number_string = phone_number.to_s
    number_string.length == 10 &&
    number_string[0].to_i >= 2 &&
    number_string[1] != number_string[2] &&
    number_string[3].to_i >= 2
  end

end
