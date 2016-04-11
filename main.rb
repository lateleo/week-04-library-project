require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "pry"

require_relative "lib/work.rb"
require_relative "lib/branch.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"
require_relative "lib/copy.rb"

require_relative "app/controllers/branches_controller.rb"
require_relative "app/controllers/staff_members_controller.rb"
require_relative "app/controllers/works_controller.rb"
require_relative "app/controllers/patrons_controller.rb"

get "/" do
  @page_name = "Home"
  erb :index
end

#binding.pry
