require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "pry"

Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }
set :views, Proc.new { File.join(root, "app/views")}

enable :method_override

get "/" do
  @page_name = "Home"
  erb :index
end

#binding.pry
