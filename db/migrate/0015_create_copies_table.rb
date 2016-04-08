class CreateCopiesTable < ActiveRecord::Migration
  def change
    create_table :copies do |t|
      t.integer :work_id
      t.integer :branch_id
      t.integer :patron_id
    end
  end
end
