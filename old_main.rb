require "active_record"
require "pry"
require "yaml"


require_relative "./lib/book.rb"
require_relative "./lib/branch.rb"
require_relative "./lib/patron.rb"
require_relative "./lib/staff_member.rb"
require_relative "./sub_menu_methods/branch_methods.rb"
require_relative "./sub_menu_methods/staff_member_methods.rb"
require_relative "./sub_menu_methods/book_methods.rb"
require_relative "./sub_menu_methods/patron_methods.rb"


# This method lists all the available options in the main sub menu
# of the given name (in this case, either branch, staff member, book or patron).
def main_sub_menu_options(sub_menu_name)
  print "---------------------------------------------------------------
  \n#{sub_menu_name.capitalize} menu options:\n
  1: List all #{sub_menu_name.pluralize}
  2: New #{sub_menu_name}
  exit: Exit to Main menu\n\nWhat would you like to do? "
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

# Passes the name of a model as a parameter, and returns it as a singularized
# string with underscores replaced with spaces.
def make_string(model_name)
  model_name.table_name.singularize.gsub(/_/," ")
end

# Used by the book, staff member, and patron sub menus to request non-unique attributes.
def request_non_unique(model, attribute)
  print "Please enter the #{model}'s #{attribute}: "
  gets.chomp
end

# Prompts the user for the given attribute for the specified model, and stalling until
# the attribute is unique. The attribute parameter is ran through gsub to replace
# spaces with underscores and then converted to a symbol so it can be used as the search
# attribute in model.find_by. The input attribute defaults to gets.chomp, but
# can be set to something else if additional validation steps are necessary.
def request_unique(model, attribute, input = gets.chomp)
  print "Please enter the #{make_string(model)}'s #{attribute}: "
  while model.find_by(attribute.gsub(/ /,"_").to_sym => (response = input))
    print "Sorry, there is already a #{make_string(model)} with that #{attribute}. Please choose another: "
  end
  response
end

binding.pry
