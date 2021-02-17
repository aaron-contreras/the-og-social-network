# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  profile_picture        :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :posts, dependent: :destroy
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'recipient_id'
  has_many :friendships
  has_many :friends, through: :friendships
  mount_uploader :profile_picture, ProfilePictureUploader

  validates_presence_of :name

  scope :not_including, ->(user) { where.not(id: user.id) }
  scope :friends_of, ->(user) { where(id: Friendship.where(user: user).pluck(:friend_id)) }

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.name = provider_data.info.name
      user.remote_profile_picture_url = provider_data.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
