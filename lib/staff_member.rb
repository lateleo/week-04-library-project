require "active_record"

class StaffMember < ActiveRecord::Base
# has two attributes, name and email, only the latter of which is unique.
  validates :name, presence: {message: "name is invalid"}
  validates :email, uniqueness: true
  validate :validate_email

  def validate_email
    unless /\A#{name.downcase.delete("^a-z")}\d{1,4}@\w+(\.[a-z]{2,3}){1,2}\Z/ =~ email
      errors.add(:email, "invalid email format")
    end
  end

end
