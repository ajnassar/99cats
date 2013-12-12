class ChangeCatRequestDateType < ActiveRecord::Migration
  change_column :cat_rental_requests, :start_date, :integer
  change_column :cat_rental_requests, :end_date, :integer
end
