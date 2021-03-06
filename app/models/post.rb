# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_presence_of :content

  scope :recent, -> { order(created_at: :desc) }

  def liked_by?(user)
    likes.find_by(user: user).present?
  end

  def feed_author_name(logged_in_user)
    author == logged_in_user ? 'You' : author.name
  end

  def auto_like
    self.likes.build(user: self.author) 
  end
end
