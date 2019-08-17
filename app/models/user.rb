class User < ApplicationRecord
  has_many :posts, foreign_key: :user_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        name:  auth.info.name,
        # password: Devise.friendly_token[0, 20],
        image:  auth.info.image
      )
    end

    user
  end

  # ログイン時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
  def password_required?
    super && provider.blank?  # provider属性に値があればパスワード入力免除
  end

  # Edit時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
  def update_with_password(params, *options)
    if encrypted_password.blank?            # encrypted_password属性が空の場合
      update_attributes(params, *options)   # パスワード入力なしにデータ更新
    else
      super
    end
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@photoapp.com"
  end
end
