require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"
require_relative "../main.rb"

# Prompts the user for a name for the staff member.
def request_staff_member_name
  print "Please enter the staff member's name: "
  name = gets.chomp
end

# Calls list_all_branches_for from branch_methods.rb to offer a list of branches if the user wishes
# and to prompt the user for a choice, and keeps prompting until the entered name matches that
# of an existing branch, before returning the id of the matching branch.
def request_staff_member_branch_id
  list_all_branches_for("staff member")
  print "Sorry, there is no branch by that name. Please try another: " until (branch = Branch.find_by(name: gets.chomp))
  branch.id
end

# Prompts the user for an email for the given staff member, and continues to do so
# until the given email matches the valid format of "staffmembername[1-4 numerals]@validdomain.name".
# usage of this method may render the validate_email method in the staff_member model obsolete,
# but I will probably leave the redundancy, just in case.
def validate_email(name)
  until /\A#{name.downcase.delete("^a-z")}\d{1,4}@\w+(\.[a-z]{2,4})+\Z/ =~ (email = gets.chomp)
    print "Sorry, the email you entered is invalid. A staff member's email must consist of their "
    print "name in lower-case followed by 1-4 numerals, an @ sign, and a valid domain name. Please try another: "
  end
end

# Calls validate_email to prompt the user for an email for the staff member to verify
# that the email is valid repeatedly until the email is unique in addition to being valid.
def request_staff_member_email(name)
  print "Please enter the staff member's email: "
  while StaffMember.find_by(email: (email = validate_email(name)))
    print "Sorry, there is already a staff member with that email. Please try another: "
  end
  email
end

# Combines all the methods involved in creating a single new staff member,
# and then asks the user if they would like to make another staff member.
# The staff member's email is not assigned when it is created because it is dependent
# on the value of the name attribute.
def create_single_staff_member
  print "\n\nVery well. You will need to provide some information about the new staff member. "
  staff_member = StaffMember.new(name: request_staff_member_name, branch_id: request_staff_member_branch_id)
  staff_member.email = request_staff_member_email(staff_member.name)
  staff_member.save
  print "\n\nGreat! #{staff_member.name} is in the system! Would you like to create another staff member (yes/no)? "
end

# Continues to run create_single_staff_member until the user is finished creating new staff members.
def create_new_staff_member
  until (continue = false)
    create_single_staff_member
    continue = yes_no?
  end
end

def browse_staff_members
  true
end
