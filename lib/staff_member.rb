require "active_record"
require_relative "branch.rb"

class StaffMember < ActiveRecord::Base
# has two attributes, name and email, only the latter of which is unique.
  validates :name, presence: {message: "cannot be blank."}
  validates :email, presence: {message: "cannot be blank."},
  uniqueness: {message: "must be unique."}
  validates :branch_id, presence: {message: "cannot be blank."}
  validate :validate_branch_id
  validate :validate_email
  belongs_to :branch

  def validate_email
    unless /\A#{name.downcase.delete("^a-z")}\d{1,4}@\w+(\.[a-z]{2,3})+\Z/ =~ email
      errors.add(:email, "must consist of a staff member's name without spaces, followed by 1-4 numbers, and a valid domain name.")
    end
  end

  def validate_branch_id
    unless Branch.find_by_id(branch_id)
      errors.add(:branch_id, "must choose a branch.")
    end
  end

end
