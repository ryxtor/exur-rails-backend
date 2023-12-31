class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :text, presence: true

  def like_count
    counts = likes.group(:liked).count
    {
      likes: counts[true] || 0,
      dislikes: counts[false] || 0
    }
  end
end
