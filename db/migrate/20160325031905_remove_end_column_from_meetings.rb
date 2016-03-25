class RemoveEndColumnFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :end, :datetime
  end
end
