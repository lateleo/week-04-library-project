require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "pry"

require_relative "lib/book.rb"
require_relative "lib/branch.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"

get "/" do
  @page_name = "Home"
  erb :index
end

### BRANCHES
get "/branches" do
  @page_name = "Branches"
  @branches = Branch.all
  erb :branches_index
end

### STAFF MEMBERS
get "/staff_members" do
  @page_name = "Staff Members"
  @staff_members = StaffMember.all
  erb :staff_members_index
end

### BOOKS
get "/books" do
  @page_name = "Books"
  @books = Book.all
  erb :books_index
end

### PATRONS
get "/patrons" do
  @page_name = "Patrons"
  @patrons = Patron.all
  erb :patrons_index
end
