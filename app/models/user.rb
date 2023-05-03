class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :books, through: :bookings

  ROLES = %w[admin staff member].freeze
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
