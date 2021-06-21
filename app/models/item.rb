class Item < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :item_comments, dependent: :destroy

  enum is_active: {ほしい:0, おねだり中:1, もらえた！:2, 自分で買った:3 }

  attachment :image, destroy: false

  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search_for(content)
      Item.where(age_want: content)
  end
end
