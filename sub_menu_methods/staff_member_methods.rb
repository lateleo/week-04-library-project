require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"

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

#---------------------------------------------------------------------

# Combines all the methods involved in creating a single new staff member,
# and then asks the user if they would like to make another staff member.
# The staff member's email is not assigned when it is created because it is dependent
# on the value of the name attribute.
def create_single_staff_member
  print "---------------------------------------------------------------
  \nVery well. You will need to provide some information about the new staff member. "
  staff_member = StaffMember.new(name: request_non_unique("staff member", "name"),
    branch_id: request_branch_id_for("staff member"))
  staff_member.email = request_unique(StaffMember, "email", validate_email(staff_member.name))
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

#---------------------------------------------------------------------

def browse_staff_members
  true
end
