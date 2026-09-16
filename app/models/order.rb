class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, processing: 1, shipped: 2, completed: 3, cancelled: 4 }

  validates :full_name, :email, :delivery_address, presence: true
  validates :total_price, numericality: { greater_than: 0 }

  PAYMENT_METHODS = [
    ["Оплата при отриманні (післяплата)", "cash_on_delivery"],
    ["Безготівковий розрахунок за реквізитами IBAN", "bank_transfer"],
    ["Оплата картою онлайн (еквайринг)", "card"]
  ].freeze

  def human_status
    I18n.t("orders.statuses.#{status}", default: status.humanize)
  end

  def self.status_options_for_select
    statuses.keys.map { |k| [I18n.t("orders.statuses.#{k}", default: k.humanize), k] }
  end
end