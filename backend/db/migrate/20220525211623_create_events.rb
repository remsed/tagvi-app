class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.datetime :eventtime
      t.string :author
      t.belongs_to :calendar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
