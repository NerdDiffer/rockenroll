class AddEnrollmentReferenceColumnToMeetings < ActiveRecord::Migration
  def change
    add_reference :meetings, :enrollment, index: true, foreign_key: true
  end
end
