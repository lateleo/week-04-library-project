### STAFF MEMBERS
get "/staff_members" do
  @page_name = "Staff Members"
  @staff_members = StaffMember.all
  erb :"staff_members/index"
end

get "/staff_members/new" do
  @page_name = "New Staff Member"
  @branches = Branch.all
  @staff_member = StaffMember.new
  erb :"staff_members/new"
end

post "/staff_members/new" do
  @page_name = "New Staff Member"
  @branches = Branch.all
  @staff_member = StaffMember.new(params)
  @staff_member.save ? redirect("/staff_members") : (erb :"staff_members/new")
end

get "/staff_members/:id" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? @staff_member.name : "Error")
  erb :"staff_members/show"
end

get "/staff_members/:id/edit" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = (@staff_member ? "Edit - #{@staff_member.name}" : "Error")
  erb :"staff_members/edit"
end

post "/staff_members/:id/edit" do
  @staff_member = StaffMember.find_by_id(params['id'])
  @page_name = (@staff_member ? "Edit - #{@staff_member.name}" : "Error")
  @branches = Branch.all
  @staff_member.update_attributes(name: params['name'], email: params['email'], branch_id: params['branch_id']) ?
  redirect("/staff_members/#{@staff_member.id}") : (erb :"staff_members/edit")
end
