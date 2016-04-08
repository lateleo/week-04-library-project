require "pry"

class Copy < ActiveRecord::Base
  #Has work_id, branch_id, and patron_id.
  validates :work_id, presence: {"cannot be blank."}
  validates :branch_id, presence: {"cannot be blank."}
  belongs_to :branch
  belongs_to :work
  belongs_to :patron

end
