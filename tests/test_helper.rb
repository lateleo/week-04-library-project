require "minitest/autorun"
require "minitest/rg"
require "sinatra/activerecord"

Dir[File.dirname(__FILE__) + '../app/models/*.rb'].each {|file| require file }
