require_relative "../lib/book.rb"
require_relative "../lib/branch.rb"
require_relative "../lib/patron.rb"
require_relative "../lib/staff_member.rb"

#
def validate_isbn
  unless /\A\d{10}(\d{3})?\Z/ =~ (response = gets.chomp)
    print "Sorry, that isbn is not a valid length. A valid isbn is either 10 or 13 digits exactly. Please try another: "
  end
  response
end

#---------------------------------------------------------------------

#
def create_single_book
  print "---------------------------------------------------------------
  \nVery well. You will need to provide some information about the new book. "
  book = Book.new(title: request_non_unique("book", "title"),
    author: request_non_unique("book", "author"),
    isbn: request_unique(Book, "isbn", validate_isbn),
    branch_id: request_branch_id_for("book"))
  book.save
  print "\n\nGreat! #{book.title} by #{book.author} is in the system! Would you like to create another book (yes/no)? "
end

#
def create_new_book
  until (continue = false)
    create_single_book
    continue = yes_no?
  end
end

#---------------------------------------------------------------------

#
def browse_books
  true
end
