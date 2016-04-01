require_relative "config/environment.rb"
require "active_record"
require "pry"
require "yaml"
require_relative "./lib/book.rb"
require_relative "./lib/branch.rb"
require_relative "./lib/patron.rb"
require_relative "./lib/staff_member.rb"

def invalid_option_message
  print "That's not a valid option. Please try again: "
end

def list_main_menu_options
  print "---------------------------------------------------------------
  Main menu options:\n
  1: Branches
  2: Staff Members
  3: Books
  4: Patrons
  exit: Exit\n
  What would you like to do? "
end

def retrieve_main_menu_choice
  list_main_menu_options
  invalid_option_message while !(/\A([1-4]|exit)\Z/ =~ (choice = gets.chomp.downcase))
  choice
end

def determine_sub_menu(choice)
  sub_menus = [:branches_menu, :staff_members_menu, :books_menu, :patrons_menu]
  send(sub_menus[(choice.to_i - 1)])
end

def main_menu
  while (choice = retrieve_main_menu_choice) != "exit"
    determine_sub_menu(choice)
  end
end

def branches_menu
  puts "--------------------------------------
  \n\nThis is the branches menu!"
end

def staff_members_menu
  puts "--------------------------------------
  \n\nThis is the staff members menu!"
end

def books_menu
  puts "--------------------------------------
  \n\nThis is the books menu!"
end

def patrons_menu
  puts "--------------------------------------
  \n\nThis is the patrons menu!"
end



binding.pry
