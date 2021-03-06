class Subscription < ApplicationRecord
	has_kms_key
  before_validation :smart_add_url_protocol

  belongs_to :user
  has_many :share_records, class_name: 'SharedSubscription', :dependent => :delete_all
  has_many :groups, through: :share_records
  accepts_nested_attributes_for :share_records, allow_destroy: true
  has_many :temp_share_records, class_name: 'TempSharedSubscription', :dependent => :delete_all
  has_many :reminders, dependent: :destroy

  # attr_encrypted_options.merge!(encryptor: SubscriptionEncryptor, encrypt_method: :encrypt, decrypt_method: :decrypt)
  attr_encrypted :username, key: Rails.env.test? || Rails.env.development? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key
  attr_encrypted :password, key: Rails.env.test? || Rails.env.development? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key

  #hiding password in gorm
  def redacted_password
    "*" * password.length
  end

	validates :username, presence: true
	validates :password, presence: true
  validates :url, :format => { :with => URI::DEFAULT_PARSER.make_regexp(%w(http https)), :message => " is not valid" }

  #search for subscriptions acessible by user
  scope :accessible_by_user, ->(user) {
    where(id: SharedSubscription.where(group_id: Group.accessible_by_user(user)).pluck(:subscription_id)).or(where(user: user))
  }

  #defining functions for subscription permissions throughout gatekeeper site
  def can_edit?(user)
    return user.can_edit?(self)
  end

  def can_view?(user)
    return user.can_view?(self)
  end

  def access_level(user)
    if (can_edit?(user))
      return SharedSubscription.permissions.key(2)
    elsif (can_view?(user))
      return SharedSubscription.permissions.key(1)
    else
      return nil
    end
  end


protected
  #securing website
  def smart_add_url_protocol
    unless url.nil? || url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      self.url = "http://#{url}"
    end
  end

end
