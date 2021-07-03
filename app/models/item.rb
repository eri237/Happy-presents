class Item < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :item_comments, dependent: :destroy

  enum is_active: {ほしい:0, おねだり中:1, もらえた！:2, 自分で買った:3 }
  #enum type: {不明:UNKNOWN, 人物:PERSON, 場所:LOCATION, 組織:ORGANIZATION, イベント:EVENT, 芸術作品:WORK_OF_ART, 商品:CONSUMER_GOOD, その他:OTHER, 電話番号:PHONE_NUMBER, 住所:ADDRESS, 日付:DATE, 数字:NUMBER, 価格:PRICE}
  self.inheritance_column = :_type_disabled # この行を追加

  attachment :image, destroy: false

  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true #欲しいitem名を入力しないと登録できない
  validates :age_want, presence: true#欲しい時の年齢を入力しないと登録できない
  validates :description, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content)
      Item.where(age_want: content)
  end
end
