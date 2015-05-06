class AddsAttributesToVice < ActiveRecord::Migration
  def change
    change_table :vices do |t|
      t.string :name
      t.string :type
      t.string :url
    end
#     add_column :vices, :url, :string
#     add_column :vices, :name, :string
#     add_column :vices, :type, :string
  end
end
