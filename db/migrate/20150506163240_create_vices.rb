class CreateVices < ActiveRecord::Migration
  def change
    create_table :vices do |t|

      t.timestamps null: false
    end
  end
end
