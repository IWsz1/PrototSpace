class Comment < ApplicationRecord
  belongs_to :user
  # dependentでprototypeが消えたら紐づくcommentも消える
  belongs_to :prototype,dependent: :destroy

  validates :content,presence:true
end
