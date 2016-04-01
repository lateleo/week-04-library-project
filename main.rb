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

def main_options(menu)
  print "---------------------------------------------------------------
  \nMain menu options:\n
  1: Branches
  2: Staff Members
  3: Books
  4: Patrons
  exit: Exit\n\nWhat would you like to do? "
end

def main_sub_menu_options(sub_menu_name)
  print "---------------------------------------------------------------
  \n#{sub_menu_name.capitalize} menu options:\n
  1: List all #{sub_menu_name.pluralize}
  2: New #{sub_menu_name}
  exit: Exit to Main menu\n\nWhat would you like to do? "
end

def retrieve_choice(menu_type, sub_menu_name)
  menu_options = {"main" => [:main_options, 4],
                  "sub menu" => [:main_sub_menu_options, 2]}
  send(menu_options[menu_type][0], sub_menu_name)
  invalid_option_message while !(/\A([1-#{menu_options[menu_type][1]}]|exit)\Z/ =~ (choice = gets.chomp.downcase))
  choice
end

def main_menu
  while (choice = retrieve_choice("main", "main")) != "exit"
    sub_menus = ["branch", "staff member", "book", "patron"]
    first_tier_sub_menu(sub_menus[choice.to_i - 1])
  end
end

def first_tier_sub_menu(sub_menu_name)
  while (choice = retrieve_choice("sub menu", sub_menu_name)) != "exit"
    sub_menus = [:browse_all, :create_new_entry]
    send(sub_menus[(choice.to_i - 1)], sub_menu_name)
  end
end

def browse_all(sub_menu_name)
  puts "---------------------------------------------------------------
  \n\nSo you'd like to browse all #{sub_menu_name.pluralize}? Right this way!\n\n\n...\n\n\n"
end

def create_new_entry(sub_menu_name)
  puts "---------------------------------------------------------------
  \n\nSo you'd like to enter a new #{sub_menu_name}? Right this way!\n\n\n...\n\n\n"
end

main_menu
#binding.pry
