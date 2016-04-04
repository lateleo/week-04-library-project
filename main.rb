require_relative "main_helper.rb"

# This method simply lists all the available options in the main menu.
# While it has a parameter, it doesn't do anything with it, but the parameter
# has to be there because of how it is called in retrieve_choice.
def main_options(menu)
  print "---------------------------------------------------------------
  \nMain menu options:\n
  1: Branches
  2: Staff Members
  3: Books
  4: Patrons
  exit: Exit\n\nWhat would you like to do? "
end

# This method lists all the available options in the main sub menu
# of the given name (in this case, either branch, staff member, book or patron).
def main_sub_menu_options(sub_menu_name)
  print "---------------------------------------------------------------
  \n#{sub_menu_name.capitalize} menu options:\n
  1: List all #{sub_menu_name.pluralize}
  2: New #{sub_menu_name}
  exit: Exit to Main menu\n\nWhat would you like to do? "
end

#---------------------------------------------------------------------

# A simple method used by retrieve_choice to inform the user that their choice
# wasn't valid and prompt them for another.
def invalid_option_message
  print "That's not a valid option. Please try again: "
end

# Used by (all?) menu methods to list the available options in the given menu
# and prompt the user for a choice, and then returns that choice. The second parameter
# is only used by first_tier_sub_menu, wherein the menu_type is "sub menu", and thus
# the method needs a name to send to main_sub_menu_options.
def retrieve_choice(menu_type, sub_menu_name = nil)
  menu_options = {"main" => [:main_options, 4],
                  "sub menu" => [:main_sub_menu_options, 2]}
  send(menu_options[menu_type][0], sub_menu_name)
  invalid_option_message while !(/\A([1-#{menu_options[menu_type][1]}]|exit)\Z/ =~ (choice = gets.chomp.downcase))
  choice
end

#---------------------------------------------------------------------

# The main menu method. continues to run until retrieve_choice returns "exit".
# On each cycle, passes a string based on the user's choice to first_tier_sub_menu,
# which indicates which records the user would like to view.
def main_menu
  while (choice = retrieve_choice("main")) != "exit"
    sub_menus = ["branch", "staff member", "book", "patron"]
    first_tier_sub_menu(sub_menus[choice.to_i - 1])
  end
end

# The method used for all four main sub menus. Originally, they were four separate
# menu methods, but they were virtually identical, so I combined them for ease of
# use and readability, and then added a string parameter that tells the method which sub menu
# it should display to the user.
def first_tier_sub_menu(sub_menu_name)
  while (choice = retrieve_choice("sub menu", sub_menu_name)) != "exit"
    sub_menus = [:browse_all, :create_new_entry]
    send(sub_menus[(choice.to_i - 1)], sub_menu_name)
  end
end

#---------------------------------------------------------------------

# requires the user to respond with "yes" or "no," stalls until the user does so,
# and returns response == "yes" (true/false)
def yes_no?
  while !["yes", "no"].include?(response = gets.chomp.downcase)
    puts "Please respond with either 'yes' or 'no'."
  end
  response == "yes"
end

# Used by first_tier_sub_menu to call the appropriate browsing method based
# on the sub menu it came from. This includes a unique method for each model
# because it is beyond this point that the paths are no longer interchangeable,
# due to the difference in columns between the different models.
def browse_all(sub_menu_name)
  browser_methods = {"branch" => :browse_branches,
                    "staff member" => :browse_staff_members,
                    "book" => :browse_books,
                    "patron" => :browse_patrons}
  send(browser_methods[sub_menu_name])
end

# Used by first_tier_sub_menu to call the appropriate creation method based
# on the sub menu it came from. This includes a unique method for each model
# because it is beyond this point that the paths are no longer interchangeable
# due to the difference in columns between the different models.
def create_new_entry(sub_menu_name)
  creation_methods = {"branch" => :create_new_branch,
                    "staff member" => :create_new_staff_member,
                    "book" => :create_new_book,
                    "patron" => :create_new_patron}
  send(creation_methods[sub_menu_name])
end


binding.pry
