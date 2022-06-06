class AddActiveToCalendars < ActiveRecord::Migration[7.0]
  def change
    add_column :calendars, :active, :boolean, null: false
  end
end
