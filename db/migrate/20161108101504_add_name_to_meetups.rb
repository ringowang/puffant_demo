class AddNameToMeetups < ActiveRecord::Migration[5.0]
  def change
    add_column :meetups, :name, :text
  end
end
