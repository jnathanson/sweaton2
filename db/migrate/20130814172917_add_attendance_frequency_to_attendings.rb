class AddAttendanceFrequencyToAttendings < ActiveRecord::Migration
  def change
    add_column :attendings, :repeated, :boolean, default: :false # true = every week, false = one-off
  end
end
