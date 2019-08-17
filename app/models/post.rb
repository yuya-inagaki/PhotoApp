class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: {message: "タイトルは必須です"}
  validates :content, presence: {message: "本文は必須です"}, length: { maximum: 500, message: "本文が長すぎます(500文字以内)" }
end
