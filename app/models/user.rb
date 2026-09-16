class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1 }

  validates :first_name, :last_name, presence: true

  has_many :carts, dependent: :nullify
  has_many :orders, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}".strip
  end
end