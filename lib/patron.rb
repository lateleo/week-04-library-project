require "active_record"
require_relative "book.rb"
require_relative "branch.rb"

class Patron < ActiveRecord::Base
# two attributes, name and email, the latter of which is unique.
  validates :name, presence: {message: "cannot be blank."}
  validates :email, presence: {message: "cannot be blank."},
  uniqueness: {message: "must be unique."},
  format: {with: /\A\w+@\w+(\.[a-z]{2,4})+\Z/, message: "must be valid."}
  has_many :books
end
