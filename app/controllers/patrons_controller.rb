### PATRONS
get "/patrons" do
  @page_name = "Patrons"
  @patrons = Patron.all
  erb :"patrons/index"
end

get "/patrons/new" do
  @page_name = "New Patron"
  @patron = Patron.new
  @branches = Branch.all
  erb :"patrons/new"
end

post "/patrons/new" do
  @page_name = "New Patron"
  @patron = Patron.new(params)
  @branches = Branch.all
  @patron.save ? redirect("/patrons") : (erb :"patrons/new")
end

get "/patrons/:id" do
  @patron = Patron.find_by_id(params['id'])
  @copies = Copy.where(patron_id: params['id'])
  @page_name = (@patron ? @patron.name : "Error")
  erb :"patrons/show"
end

get "/patrons/:id/edit" do
  @patron = Patron.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = (@patron ? "Edit - #{@patron.name}" : "Error")
  erb :"patrons/edit"
end

post "/patrons/:id/edit" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Edit - #{@patron.name}" : "Error")
  @branches = Branch.all
  @patron.update_attributes(name: params['name'], email: params['email'], branch_id: params['branch_id']) ?
  redirect("/patrons/#{@patron.id}") : (erb :"patrons/edit")
end

get "/patrons/:id/checkout" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Checkout - #{@patron.name}" : "Error")
  @branch = Branch.find_by_id(params['branch_id'])
  @copies = Copy.all
  @works = Work.all
  erb :"patrons/checkout"
end

post "/patrons/:id/checkout" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Checkout - #{@patron.name}" : "Error")
  @branch = Branch.find_by(id: params['branch_id'])
  @copy = Copy.find_by_id(params['copy_id'])
  @copy.update_attributes(patron_id: params['id']) ?
    redirect("/patrons/#{@patron.id}") : (erb :"patrons/checkout")
end

get "/patrons/:id/return" do
  @patron = Patron.find_by_id(params['id'])
  @page_name = (@patron ? "Return Items - #{@patron.name}" : "Error")
  @errors = []
  @copies = Copy.where(patron_id: params['id'])
  erb :"patrons/return"
end

post "/patrons/:id/return" do
  @patron = Patron.find_by_id(params['id'])
  @copies = Copy.where(patron_id: params['id'])
  @errors = []
  @copies.each {|copy| @errors.push(copy.branch.id) if
    (params[copy.id.to_s] == copy.id.to_s) && !(copy.branch.staff_members.any?) && !(@errors.include?(copy.branch.id))}
  if @errors.any?
    erb :"patrons/return"
  else
    @copies.each {|copy| copy.update_attributes(patron_id: nil) if params[copy.id.to_s] == copy.id.to_s}
    redirect("/patrons/#{params['id']}")
  end
end
