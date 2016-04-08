class RemovePatronIdColumnFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :patron_id, :string
  end
end
