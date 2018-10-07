class DaysOfTheWeekMembership < ApplicationRecord
  belongs_to :team
  enum day:
    [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
end
