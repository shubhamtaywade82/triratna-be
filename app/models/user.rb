class User < ApplicationRecord
  has_secure_password validations: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 20 }
  validates :mobile, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A\d{10}\z/ }
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 20 }

  validates :password,
            presence: true,
            length: { minimum: 6, maximum: 50 },
            format: {
              with: /\A(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).{6,}\z/,
              message: I18n.t("errors.user.attributes.password.invalid", special_characters: '!@#$%^&*(),.?":{}|<>')
            }
end
