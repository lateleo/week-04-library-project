require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"

# Passes a phone_number parameter, and converts it to "xxx-xxx-xxxx" format if it's the proper length.
def format_phone_number(phone_number)
  phone_number.delete!("^0-9")
  phone_number.slice!(0) if (phone_number[0] == "1" && phone_number.length > 10)
  [3,7].each {|n| phone_number.insert(n, "-")} if phone_number.length == 10
  phone_number
end

# Prompts the user to enter a phone number for a branch, calls format_phone_number on it, and stalls
# until the entered number matches the regexp representing the rules for valid phone numbers in North America.
# A more rigorous explanation of the regexp can be found in the branch model file, as it's the same
# one used in the validates clause.
def validate_branch_phone_number
  until /\A[2-9](\d)(?!\1)\d-[2-9]\d\d-\d{4}\Z/ =~ (phone_number = format_phone_number(gets.chomp))
    print "Sorry, that is not a valid phone number. Please try another: "
  end
  phone_number
end

#---------------------------------------------------------------------

# Combines all the methods involved in creating a single new branch,
# and then asks the user if they would like to make another branch.
def create_single_branch
  print "---------------------------------------------------------------
  \nVery well. You will need to provide some information about the new branch. "
  branch = Branch.new(name: request_unique(Branch, "name"),
  address: request_unique(Branch, "address"),
  phone_number: request_unique(Branch, "phone number", validate_branch_phone_number))
  branch.save
  puts "\n\nGreat! The #{branch.name} branch is in the system! Would you like to create another branch (yes/no)? "
end

# Continues to run create_single_branch repeatedly until the user is finished creating new branches.
def create_new_branch
  while (continue = false)
    create_single_branch
    continue = yes_no?
  end
end

#---------------------------------------------------------------------

def browse_branches
  true
end

#---------------------------------------------------------------------

# This method is inteded to be used in sub menus for books and staff members.
# It takes as a parameter the kind of object the model is for, informs the user that the object needs to be
# assigned to a branch, offers to list all branches if desired, and then requests that the user specifies
# a branch to which to assign the given object.
def list_all_branches_for(object)
  print "Each #{object} needs to be assigned to a branch. Would you like to see a list of branches (yes/no)? "
  (Branches.all.each {|branch| puts "- #{branch.name}: #{branch.address}; #{branch.phone_number}"}) if yes_no?
  print "\nPlease enter the name of the branch to which you would like to assign the #{object}: "
end

# This method is intended to be used in the book and staff member sub menus, but is listed here because
# It specifically pertains to branches, and is used by multiple sub menus. It takes as a parameter
# the kind of object the model is for, passes that object to list_all_branches_for to offer a list of branches
# and prompt the user for a choice, then stalls until the user enters the name of an existing branch.
def request_branch_id_for(object)
  list_all_branches_for(object)
  print "Sorry, there is no branch by that name. Please try another: " until (branch = Branch.find_by(name: gets.chomp))
  branch.id
end
