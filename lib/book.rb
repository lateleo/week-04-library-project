require "active_record"
require_relative "branch.rb"
require_relative "patron.rb"

class Book < ActiveRecord::Base
# three attributes: title, author and ISBN, the latter of which is unique.
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true
  validates :branch_id, presence: true
  belongs_to :branch
  belongs_to :patron
end
