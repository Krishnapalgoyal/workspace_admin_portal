class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organization_memberships, dependent: :destroy
  has_many :organizations, through: :organization_memberships
end
