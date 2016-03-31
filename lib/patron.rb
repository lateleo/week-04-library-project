require "active_record"

class Patron < ActiveRecord::Base
# two attributes, name and email, the latter of which is unique.
  validates :name, presence: true
  validates :email, uniqueness: true, format: {with: /\A\w+@\w+\.\w{2,3}\Z/}
end
