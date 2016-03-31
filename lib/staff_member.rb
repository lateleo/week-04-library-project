require "active_record"

class StaffMember < ActiveRecord::Base
# has two attributes, name and email, only the latter of which is unique.
  validates :name, presence: {message: "name is invalid"}
  validates :email, uniqueness: true#, format: {with: /\A#{name}\d{1,4}@\w+\.[a-z]{2,3}\Z/, message: "email is invalid"}
  before_validation :validate_email

  def validate_email
    /\A#{name.delete("^a-zA-Z").downcase}\d{1,4}@\w+\.[a-z]{2,3}\Z/ =~ email ? true : false
  end

end
