require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"
require_relative "../main.rb"

def request_branch_name
  print "Please enter the desired name for the branch: "
  while Branch.find_by(name: (name = gets.chomp))
    print "Sorry, there is already a library branch by that name. Please choose another: "
  end
  name
end

def request_branch_address
  print "Please enter the street address for the branch: "
  while Branch.find_by(address: (address = gets.chomp))
    print "Sorry, there is already a library branch at that location. Please try another: "
  end
  address
end

def format_phone_number(phone_number)
  phone_number.delete!("^0-9")
  phone_number.slice!(0) if (phone_number[0] == "1" && phone_number.length > 10)
  [3,7].each {|n| phone_number.insert(n, "-")} if phone_number.length == 10
  phone_number
end

def validate_branch_phone_number
  until /\A[2-9](\d)(?!\1)\d-[2-9]\d\d-\d{4}\Z/ =~ (phone_number = format_phone_number(gets.chomp))
    print "Sorry, that is not a valid phone number. Please try another: "
  end
  phone_number
end

def request_branch_phone_number
  print "Please enter the phone number for the branch: "
  while Branch.find_by(phone_number: (phone_number = validate_branch_phone_number))
    print "Sorry, that phone number is already registered with another branch. Please try another: "
  end
  phone_number
end


def create_new_branch
  print "\n\nVery well. You will need to provide some information about the new branch. "
  branch = Branch.new(name: request_branch_name, address: request_branch_address, phone_number: request_branch_phone_number)
  branch.save
  puts "\n\nGreat! The #{branch.name} branch is in the system!\n\n"
end

# This method is inteded to be used in sub menus for other models (specifically, books and staff members).
# It takes as a parameter the kind of object the model is for, informs the user that the object needs to be
# assigned to a branch, offers to list all branches if desired, and then requests that the user specifies
# a branch to which to assign the given object.
def list_all_branches_for(object)
  print "Each #{object} needs to be assigned to a branch. Would you like to see a list of branches (yes/no)? "
  (Branches.all.each {|branch| puts "- #{branch.name}: #{branch.address}; #{branch.phone_number}"}) if require_yes_no
  print "\nPlease enter the name of the branch to which you would like to assign the #{object}: "
end

def browse_branches
  true
end
