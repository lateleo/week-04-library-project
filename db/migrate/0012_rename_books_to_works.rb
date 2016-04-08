class RenameBooksToWorks < ActiveRecord::Migration
  def change
    rename_table :books, :works
  end
end
