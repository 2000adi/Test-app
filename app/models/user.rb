class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :books, through: :bookings
  has_many :user_books
  ROLES = %w[admin staff member].freeze
  validates :role, inclusion: { in: ROLES }

  def member?
    role == 'member'
  end

  def admin?
    role == 'admin'
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
