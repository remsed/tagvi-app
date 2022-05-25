class CreateJoinTableCalendarUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :calendars, :users do |t|
      # t.index [:calendar_id, :user_id]
      # t.index [:user_id, :calendar_id]
    end
  end
end
