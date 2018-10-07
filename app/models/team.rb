class Team < ApplicationRecord
  include Friendlyable
  belongs_to :account
  validates :account, presence: true
  validates :timezone, presence: true
  validates :name, presence: true

  has_many :team_memberships, dependent: :delete_all
  has_many :users, through: :team_memberships

  has_many :days, class_name: 'DaysOfTheWeekMembership'
  accepts_nested_attributes_for :days
end
