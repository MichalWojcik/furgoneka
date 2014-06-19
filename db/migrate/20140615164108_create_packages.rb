class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.datetime :pickup_date
      t.datetime :delivery_date
      t.string :status
      t.string :receiver_street
      t.string :receiver_city

      t.timestamps
    end
  end
end
