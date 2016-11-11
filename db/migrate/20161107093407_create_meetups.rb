class CreateMeetups < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |t|
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
