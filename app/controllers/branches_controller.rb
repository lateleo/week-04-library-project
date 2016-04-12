### BRANCHES
get "/branches" do
  @page_name = "Branches"
  @branches = Branch.all
  erb :"branches/index"
end

get "/branches/new" do
  @page_name = "New Branch"
  @branch = Branch.new
  erb :"branches/new"
end

post "/branches/new" do
  @page_name = "New Branch"
  params['phone_number'] = params['area'] + params['coc'] + params['local']
  ['area', 'coc', 'local'].each {|code| params.delete(code)}
  @branch = Branch.new(params)
  @branch.save ? redirect("/branches") : (erb :"branches/new")
end

get "/branches/:id" do
  @branch = Branch.find_by_id(params['id'])
  @staff_members = StaffMember.where(branch_id: params['id'])
  @page_name = (@branch ? @branch.name : "Error")
  erb :"branches/show"
end

get "/branches/:id/edit" do
  @branch = Branch.find_by_id(params['id'])
  @page_name = (@branch ? "Edit - #{@branch.name}" : "Error")
  erb :"branches/edit"
end

post "/branches/:id/edit" do
  @branch = Branch.find_by_id(params['id'])
  @page_name = (@branch ? "Edit - #{@branch.name}" : "Error")
  params['phone_number'] = params['area'] + params['coc'] + params['local']
  ['area', 'coc', 'local'].each {|code| params.delete(code)}
  @branch.update_attributes(name: params['name'], address: params['address'], phone_number: params['phone_number']) ?
    redirect("/branches/#{@branch.id}") : (erb :"branches/edit")
end
