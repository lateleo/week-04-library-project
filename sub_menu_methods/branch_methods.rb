require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"
require_relative "../main.rb"

def request_branch_name
  "Please enter the desired name for the branch: "
  while Branch.find_by(name: (name = gets.chomp))
    print "Sorry. There is already a library branch by that name. Please choose another: "
  end
  name
end

def request_branch_address
  "Please enter the street address for the branch: "
  while Branch.find_by(address: (address = gets.chomp))
    print "Sorry. There is already a library branch at that location. Please choose another: "
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
  while !(/\A[2-9](\d)(?!\1)\d-[2-9]\d\d-\d{4}\Z/ =~ (phone_number = format_phone_number(gets.chomp)))
    print "Sorry. That is not a valid phone number. Please try another: "
  end
  phone_number
end

def request_branch_phone_number
  print "Please enter the phone number for the branch: "
  while Branch.find_by(phone_number: (phone_number = validate_branch_phone_number))
    print "Sorry. That phone number is already registered with another branch. Please choose another: "
  end
  phone_number
end

def create_new_branch
  print "\n\nVery well. You will need to provide some information about the new branch. "
  branch = Branch.new(name: request_branch_name, address: request_branch_address, phone_number: request_branch_phone_number)
  branch.save
  puts "\n\nGreat! The new branch is in the system!\n\n"
end

def browse_branches
  true
end
