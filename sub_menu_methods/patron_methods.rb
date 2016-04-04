require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"

#
def validate_email
  until /\A\w+@\w+(\.[a-z]{2,4})+\Z/ =~ (response = gets.chomp)
    print "Sorry, the email you entered is invalid. A patron's email must consist of "
    print "a series of letters, numbers, and/or underscores, followed by an @ sign and a valid domain. "
    print "Please try another: "
  end
  response
end

#---------------------------------------------------------------------

#
def create_single_patron
  print "---------------------------------------------------------------
  \nVery well. You will need to provide some information about the new patron. "
  patron = Patron.new(name: request_non_unique("patron", "name"), email: request_unique(Patron, "email", validate_email))
  patron.save
  puts "\n\nGreat! #{branch.name} is in the system! Would you like to create another patron (yes/no)? "
end

#
def create_new_patron
  while (continue = false)
    create_single_patron
    continue = yes_no?
  end
end

#---------------------------------------------------------------------

#
def browse_patrons
  true
end
