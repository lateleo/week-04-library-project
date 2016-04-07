require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "pry"

require_relative "./lib/book.rb"
require_relative "./lib/branch.rb"
require_relative "./lib/patron.rb"
require_relative "./lib/staff_member.rb"

get "/" do
  binding.pry
end
