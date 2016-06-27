class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :joins, dependent: :destroy
  has_many :joined_users, through: :joins, source: :user
  validates(:title, presence: true, uniqueness:{scope: :user_id},
            length: {minimum: 2})
  validates :body, presence: true, length: {minimum: 2}


  def joined_by?(user)
    joins.exists?(user:user)
  end
  def join_for(user)
   joins.find_by_user_id user
  end
  def liked_by?(user)
    likes.exists?(user:user)
  end
  def like_for(user)
   likes.find_by_user_id user
  end



end
