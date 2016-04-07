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

get "/branches/new" do
  @page_name = "New Branch"
  @branch = Branch.new
  erb :branches_new
end

post "/branches/new" do
  @page_name = "New Branch"
  params['phone_number'] = params['area'] << params['coc'] << params['local']
  ['area', 'coc', 'local'].each {|code| params.delete(code)}
  @branch = Branch.new(params)
  @branch.save ? redirect("/branches") : (erb :branches_new)
end

get "/branches/:id" do
  @branch = Branch.find_by_id(params['id'])
  @page_name = @branch.name
  erb :branches_show
end

### STAFF MEMBERS
get "/staff_members" do
  @page_name = "Staff Members"
  @staff_members = StaffMember.all
  erb :staff_members_index
end

get "/staff_members/new" do
  @page_name = "New Staff Member"
  @staff_member = StaffMember.new
  erb :staff_members_new
end

post "/staff_members/new" do
  @page_name = "New Staff Member"
  @staff_member = StaffMember.new(params)
  @staff_member.save ? redirect("/staff_members") : (erb :staff_members_new)
end

get "/staff_members/:id" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? @staff_member.name : "Error")
  erb :staff_members_show
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
