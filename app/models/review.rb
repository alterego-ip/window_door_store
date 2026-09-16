class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true, inclusion: { in: 1..5, message: "має бути від 1 до 5 зірок" }
  validates :comment, presence: { message: "відгуку не може бути порожнім" }, length: { minimum: 5, message: "має містити щонайменше 5 символів" }
  validates :user_id, uniqueness: { scope: :product_id, message: "може залишити лише один відгук для цієї позиції" }
end