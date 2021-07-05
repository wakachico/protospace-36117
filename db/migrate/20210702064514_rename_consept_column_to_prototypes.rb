class RenameConseptColumnToPrototypes < ActiveRecord::Migration[6.0]
  def change
    rename_column :prototypes, :consept, :concept
  end
end
