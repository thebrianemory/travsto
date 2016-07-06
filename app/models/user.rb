class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username, :email
  validates :username, format: { with: /\A[a-z0-9.]{6,20}\z/i }
  has_many :trips, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum role: [:user, :admin]

  extend FriendlyId
  friendly_id :username, use: :slugged

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user_info|
      user_info.provider = auth.provider
      user_info.uid = auth.uid
      user_info.email = auth.info.email
      fullname = auth.info.name.split
      user_info.first_name = fullname.first
      user_info.last_name = fullname.last
      user_info.username = auth.info.email.split("@")[0].gsub(/[.]/, '') + Faker::Number.between(1, 999).to_s
      user_info.password = Devise.friendly_token[0,20]
      user_info.password_confirmation = user_info.password
      user_info.role = 0
      user_info.save!
    end
  end

  def name
    [first_name, last_name]. join(' ')
  end
end
