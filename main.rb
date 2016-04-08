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
#-------------------------------------------------------------------------------------------------------------
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
  @staff_members = StaffMember.where(branch_id: params['id'])
  @page_name = (@branch ? @branch.name : "Error")
  erb :branches_show
end

#-------------------------------------------------------------------------------------------------------------
### STAFF MEMBERS
get "/staff_members" do
  @page_name = "Staff Members"
  @staff_members = StaffMember.all
  erb :staff_members_index
end

get "/staff_members/new" do
  @page_name = "New Staff Member"
  @branches = Branch.all
  @staff_member = StaffMember.new
  erb :staff_members_new
end

post "/staff_members/new" do
  @page_name = "New Staff Member"
  @branches = Branch.all
  @staff_member = StaffMember.new(params)
  @staff_member.save ? redirect("/staff_members") : (erb :staff_members_new)
end

get "/staff_members/:id" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? @staff_member.name : "Error")
  erb :staff_members_show
end

get "/staff_members/:id/edit" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = (@staff_member ? "#{@staff_member.name} - Edit" : "Error")
  erb :staff_members_edit
end

post "/staff_members/:id" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? "#{@staff_member.name} - Edit" : "Error")
  @staff_member.update_attributes(name: params['name'], email: params['email'], branch_id: params['branch_id']) ?
  redirect("/staff_members/#{@staff_member.id}") : (erb :staff_members_edit)
end

#-------------------------------------------------------------------------------------------------------------
### BOOKS
get "/books" do
  @page_name = "Books"
  @books = Book.all
  erb :books_index
end

get "/books/new" do
  @page_name = "New Book"
  @branches = Branch.all
  @book = Book.new
  erb :books_new
end

post "/books/new" do
  @page_name = "New Book"
  @branches = Branch.all
  @book = Book.new(params)
  @book.save ? redirect("/books") : (erb :books_new)
end

get "/books/:id" do
  @book = Book.find_by_id(params['id'])
  @page_name = (@book ? @book.title : "Error")
  erb :books_show
end

#-------------------------------------------------------------------------------------------------------------
### PATRONS
get "/patrons" do
  @page_name = "Patrons"
  @patrons = Patron.all
  erb :patrons_index
end

get "/patrons/new" do
  @page_name = "New Patron"
  @patron = Patron.new
  erb :patrons_new
end

post "/patrons/new" do
  @page_name = "New Patron"
  @patron = Patron.new(params)
  @patron.save ? redirect("/patrons") : (erb :patrons_new)
end

get "/patrons/:id" do
  @patron = Patron.find_by_id(params['id'])
  @books = Book.where(patron_id: params['id'])
  @page_name = (@patron ? @patron.name : "Error")
  erb :patrons_show
end

#binding.pry
