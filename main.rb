require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "pry"

require_relative "lib/work.rb"
require_relative "lib/branch.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"
require_relative "lib/copy.rb"

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

get "/branches/:id/edit" do
  @branch = Branch.find_by_id(params['id'])
  @page_name = (@branch ? "Edit - #{@branch.name}" : "Error")
  erb :branches_edit
end

post "/branches/:id/edit" do
  @branch = Branch.find_by_id(params['id'])
  @page_name = (@branch ? "Edit - #{@branch.name}" : "Error")
  params['phone_number'] = params['area'] << params['coc'] << params['local']
  ['area', 'coc', 'local'].each {|code| params.delete(code)}
  @branch.update_attributes(name: params['name'], address: params['address'], phone_number: params['phone_number']) ?
  redirect("/branches/#{@branch.id}") : (erb :branches_edit)
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
  @page_name = (@staff_member ? "Edit - #{@staff_member.name}" : "Error")
  erb :staff_members_edit
end

post "/staff_members/:id/edit" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? "Edit - #{@staff_member.name}" : "Error")
  @branches = Branch.all
  @staff_member.update_attributes(name: params['name'], email: params['email'], branch_id: params['branch_id']) ?
  redirect("/staff_members/#{@staff_member.id}") : (erb :staff_members_edit)
end

#-------------------------------------------------------------------------------------------------------------
### BOOKS
get "/works" do
  @page_name = "Works"
  @works = Work.all
  erb :works_index
end

get "/works/new" do
  @page_name = "New Work"
  @work = Work.new
  erb :works_new
end

post "/works/new" do
  @page_name = "New Work"
  @work = Work.new(params)
  @work.save ? redirect("/works") : (erb :works_new)
end

get "/works/:id" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? @work.title : "Error")
  @branches = Branch.all
  @patrons = Patron.all
  @copies = Copy.where(work_id: params['id'])
  erb :works_show
end

get "/works/:id/edit" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? "Edit - #{@work.title}" : "Error")
  erb :works_edit
end

post "/works/:id/edit" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? "Edit - #{@work.title}" : "Error")
  @work.update_attributes(title: params['title'], author: params['author'],
  year: params['year'], isbn: params['isbn']) ?
  redirect("/works/#{@work.id}") : (erb :works_edit)
end

get "/works/:id/new_copy" do
  @work = Work.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = "#{@work.title} - New Copy"
  @copy = Copy.new(work_id: params['id'])
  erb :copies_new
end

post "/works/:id/new_copy" do
  @work = Work.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = "#{@work.title} - New Copy"
  @copy = Copy.new(work_id: params['id'], branch_id: params['branch_id'])
  @copy.save ? redirect("/works/#{@work.id}") : (erb :copies_new)
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
  @branches = Branch.all
  erb :patrons_new
end

post "/patrons/new" do
  @page_name = "New Patron"
  @patron = Patron.new(params)
  @branches = Branch.all
  @patron.save ? redirect("/patrons") : (erb :patrons_new)
end

get "/patrons/:id" do
  @patron = Patron.find_by_id(params['id'])
  @copies = Copy.where(patron_id: params['id'])
  @branches = Branch.all
  @page_name = (@patron ? @patron.name : "Error")
  erb :patrons_show
end

get "/patrons/:id/edit" do
  @patron = Patron.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = (@patron ? "Edit - #{@patron.name}" : "Error")
  erb :patrons_edit
end

post "/patrons/:id/edit" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Edit - #{@patron.name}" : "Error")
  @branches = Branch.all
  @patron.update_attributes(name: params['name'], email: params['email'], branch_id: params['branch_id']) ?
  redirect("/patrons/#{@patron.id}") : (erb :patrons_edit)
end

get "/patrons/:id/checkout" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Checkout - #{@patron.name}" : "Error")
  @branch = Branch.find_by_id(params['branch_id'])
  @copies = Copy.all
  @works = Work.all
  erb :patrons_checkout
end

post "/patrons/:id/checkout" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Checkout - #{@patron.name}" : "Error")
  @branch = Branch.find_by(id: params['branch_id'])
  @copy = Copy.find_by_id(params['copy_id'])
  @copy.update_attributes(patron_id: params['id']) ?
    redirect("/patrons/#{@patron.id}") : (erb :patrons_checkout)
end

get "/patrons/:id/return" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Return Items - #{@patron.name}" : "Error")
  @errors = []
  @copies = Copy.where(patron_id: params['id'])
  erb :patrons_return
end

post "/patrons/:id/return" do
  @patron = Patron.find_by_id(params['id'])
  @copies = Copy.where(patron_id: params['id'])
  @errors = []
  @copies.each {|copy| @errors.push(copy.branch.id) if
    (params[copy.id.to_s] == copy.id.to_s) && !(copy.branch.staff_members.any?) && !(@errors.include?(copy.branch.id))}
  if @errors.any?
    erb :patrons_return
  else
    @copies.each {|copy| copy.update_attributes(patron_id: nil) if params[copy.id.to_s] == copy.id.to_s}
    redirect("/patrons/#{params['id']}")
  end
end
#binding.pry
