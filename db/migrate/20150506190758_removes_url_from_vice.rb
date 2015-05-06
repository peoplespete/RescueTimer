class RemovesUrlFromVice < ActiveRecord::Migration
  def change
    remove_column :vices, :url

  end
end
