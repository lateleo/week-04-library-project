require "active_record"
require "pry"

class Patron < ActiveRecord::Base
# two attributes, name and email, the latter of which is unique.
  validates :name, presence: {message: "cannot be blank."}
  validates :email, presence: {message: "cannot be blank."},
  uniqueness: {message: "must be unique."},
  format: {with: /\A\w+@\w+(\.[a-z]{2,4})+\Z/, message: "must be valid."}
  validates :branch_id, presence: {message: "cannot be blank."}
  has_many :copies
  belongs_to :branch


  def do_pry
    binding.pry
  end

end
