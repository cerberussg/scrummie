class User < ApplicationRecord
  include Friendlyable
  rolify
  attr_accessor :role
  belongs_to :account, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :team_memberships
  has_many :teams, through: :team_memberships
end
