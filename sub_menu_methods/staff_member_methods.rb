require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"
require_relative "../main.rb"

def request_staff_member_name
  print "Please enter the staff member's name: "
  name = gets.chomp
end

def request_staff_member_branch_id
  list_all_branches("staff member")
  print "Sorry, there is no branch by that name. Please try another: " until (branch = Branch.find_by(name: gets.chomp))
  branch.id
end

def validate_email(name)
  until /\A#{name.downcase.delete("^a-z")}\d{1,4}@\w+(\.[a-z]{2,3})+\Z/ =~ (email = gets.chomp)
    print "Sorry, the email you entered is invalid. A staff member's email must consist of their "
    print "name in lower-case followed by 1-4 numerals, an @ sign, and a valid domain name. Please try another: "
  end
end

def request_staff_member_email(name)
  print "Please enter the staff member's email: "
  while StaffMember.find_by(email: (email = validate_email(name)))
    print "Sorry, there is already a staff member with that email. Please try another: "
  end
  email
end

def create_new_staff_member
  print "\n\nVery well. You will need to provide some information about the new staff member. "
  staff_member = StaffMember.new(name: request_staff_member_name, branch_id: request_staff_member_branch_id)
  staff_member.email = request_staff_member_email(staff_member.name)
  staff_member.save
  puts "\n\nGreat! #{staff_member.name} is in the system!\n\n"
end

def browse_staff_members
  true
end
