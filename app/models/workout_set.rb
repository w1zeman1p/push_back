# == Schema Information
#
# Table name: workout_sets
#
#  id         :integer          not null, primary key
#  reps       :integer
#  workout_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class WorkoutSet < ActiveRecord::Base
end
