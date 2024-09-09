# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :icon

  validate :correct_icon_type

  private

  def correct_icon_type
    return if !icon.attached?

    errors.add(:icon, I18n.t('errors.validate_mime_type')) unless icon.content_type.in?(ALLOWED_CONTENT_TYPES)
  end
end
