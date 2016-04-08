require "active_record"
require_relative "branch.rb"
require_relative "patron.rb"
require "pry"

class Book < ActiveRecord::Base
# three attributes: title, author and ISBN, the latter of which is unique.
  validates :title, presence: {message: "cannot be blank."}
  validates :author, presence: {message: "cannot be blank."}
  validates :isbn, presence: {message: "cannot be blank."},
  uniqueness: {message: "must be unique."}
  validates :branch_id, presence: {message: "cannot be blank."}
  validate :validate_isbn
  belongs_to :branch
  belongs_to :patron

  def validate_checksum
    sum = 0
    isbn.chars.each_with_index{|n,i| sum += n.to_i*((isbn.size == 10) ? (10-i) : (i.odd? ? 3 : 1))}
    isbn.size == 10 ? sum % 11 == 0 : sum % 10 == 0
  end

  def validate_isbn
    isbn.gsub!("-","")
    errors.add(:isbn, "must be valid.") unless (/\A(97[89])?\d{10}\Z/ =~ isbn) && validate_checksum
  end
end
