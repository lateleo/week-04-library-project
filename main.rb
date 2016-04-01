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

def main_options
  print "---------------------------------------------------------------
  Main menu options:\n
  1: Branches
  2: Staff Members
  3: Books
  4: Patrons
  exit: Exit\n
  What would you like to do? "
end

def branch_options
  print "---------------------------------------------------------------
  Branch menu options:\n
  1: List all branches
  2: New branch
  exit: Exit to Main menu\n
  What would you like to do? "
end

def staff_member_options
  print "---------------------------------------------------------------
  Staff member menu options:\n
  1: Browse all staff members
  2: New staff member
  exit: Exit to Main menu\n
  What would you like to do? "
end

def book_options
  print "---------------------------------------------------------------
  Book menu options:\n
  1: Browse all books
  2: New book
  exit: Exit to Main menu\n
  What would you like to do? "
end

def patron_options
  print "---------------------------------------------------------------
  Patron menu options:\n
  1: Browse all patrons
  2: New patron
  exit: Exit to Main menu\n
  What would you like to do? "
end

def retrieve_choice(menu)
  menu_options = {"main" => [:main_options, 4],
                  "branch" => [:branch_options, 2],
                  "staff" => [:staff_member_options, 2],
                  "book" => [:book_options, 2],
                  "patron" => [:patron_options, 2]}
  send(menu_options[menu[0]])
  invalid_option_message while !(/\A([1-#{menu_options[menu[1]]}]|exit)\Z/ =~ (choice = gets.chomp.downcase))
  choice
end

def main_menu
  while (choice = retrieve_choice("main")) != "exit"
    sub_menus = [:branches_menu, :staff_members_menu, :books_menu, :patrons_menu]
    send(sub_menus[(choice.to_i - 1)])
  end
end

def branches_menu
  while (choice = retrieve_choice("branches")) != "exit"
    sub_menus = [:browse_all_branches, :new_branch]
    send(sub_menus[(choice.to_i - 1)])
  end
end

def staff_members_menu
  while (choice = retrieve_choice("staff")) != "exit"
    sub_menus = [:browse_all_staff_members, :new_staff_member]
    send(sub_menus[(choice.to_i - 1)])
  end
end

def books_menu
  while (choice = retrieve_choice("books")) != "exit"
    sub_menus = [:browse_all_books, :new_book]
    send(sub_menus[(choice.to_i - 1)])
  end
end

def patrons_menu
  while (choice = retrieve_choice("patrons")) != "exit"
    sub_menus = [:browse_all_patrons, :new_patron]
    send(sub_menus[(choice.to_i - 1)])
  end
end



binding.pry
