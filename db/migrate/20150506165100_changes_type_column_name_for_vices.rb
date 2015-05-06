class ChangesTypeColumnNameForVices < ActiveRecord::Migration
  def change
    change_table :vices do |t|
      t.rename :type, :category
    end
  end
end
