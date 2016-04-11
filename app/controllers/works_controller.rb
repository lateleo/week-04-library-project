### WORKS
get "/works" do
  @page_name = "Works"
  @works = Work.all
  erb :"works/index"
end

get "/works/new" do
  @page_name = "New Work"
  @work = Work.new
  erb :"works/new"
end

post "/works/new" do
  @page_name = "New Work"
  @work = Work.new(params)
  @work.save ? redirect("/works") : (erb :"works/new")
end

get "/works/:id" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? @work.title : "Error")
  @branches = Branch.all
  @patrons = Patron.all
  @copies = Copy.where(work_id: params['id'])
  erb :"works/show"
end

get "/works/:id/edit" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? "Edit - #{@work.title}" : "Error")
  erb :"works/edit"
end

post "/works/:id/edit" do
  @work = Work.find_by_id(params['id'])
  @page_name = (@work ? "Edit - #{@work.title}" : "Error")
  @work.update_attributes(title: params['title'], author: params['author'],
  year: params['year'], isbn: params['isbn']) ?
  redirect("/works/#{@work.id}") : (erb :"works/edit")
end

get "/works/:id/new_copy" do
  @work = Work.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = "#{@work.title} - New Copy"
  @copy = Copy.new(work_id: params['id'])
  erb :"works/new_copy"
end

post "/works/:id/new_copy" do
  @work = Work.find_by_id(params['id'])
  @branches = Branch.all
  @page_name = "#{@work.title} - New Copy"
  @copy = Copy.new(work_id: params['id'], branch_id: params['branch_id'])
  @copy.save ? redirect("/works/#{@work.id}") : (erb :"works/new_copy")
end
