require "pry"

class Work < ActiveRecord::Base
# four attributes: title, author, year and ISBN, the latter of which is unique.
  validates :title, presence: {message: "cannot be blank."}
  validates :author, presence: {message: "cannot be blank."}
  validates :year, presence: {message: "cannot be blank."},
    numericality: {allow_nil: true, less_than_or_equal_to: Time.now.year, message: "cannot be in the future."}
  validates :isbn, presence: {message: "cannot be blank."},
    uniqueness: {message: "must be unique."}
  validate :validate_isbn
  has_many :copies

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
