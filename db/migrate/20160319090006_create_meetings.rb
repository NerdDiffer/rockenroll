class CreateMeetings < ActiveRecord::Migration
  def up
    execute(create_enum_type)

    create_table :meetings do |t|
      t.datetime :start
      t.datetime :end
      t.column   :length, :meeting_length
      t.integer  :course_id
      t.integer  :room_id

      t.timestamps null: false
    end
  end

  def down
    drop_table :meetings
    execute(drop_enum_type)
  end

  private

  def create_enum_type
    "CREATE TYPE meeting_length AS ENUM ('20', '30', '45', '60', '75', '90');"
  end

  def drop_enum_type
    'DROP TYPE meeting_length;'
  end
end
