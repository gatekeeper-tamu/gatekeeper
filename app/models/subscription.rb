class Subscription < ApplicationRecord
	has_kms_key
  before_validation :smart_add_url_protocol
	
  belongs_to :user
  has_many :share_records, class_name: 'SharedSubscription', :dependent => :delete_all 
  has_many :groups, through: :share_records
  accepts_nested_attributes_for :share_records, allow_destroy: true
  # has_many :reminders

  # attr_encrypted_options.merge!(encryptor: SubscriptionEncryptor, encrypt_method: :encrypt, decrypt_method: :decrypt)
  attr_encrypted :username, key: Rails.env.test? || Rails.env.development? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key
  attr_encrypted :password, key: Rails.env.test? || Rails.env.development? ? '2K31QRnurJBWvtWkTE3uXfKA7vivrvA5' : :kms_key

  def redacted_password
    "*" * password.length
  end

	validates :username, presence: true
	validates :password, presence: true
  validates :url, :format => { :with => URI::regexp(%w(http https)), :message => " is not valid" }

  scope :accessible_by_user, ->(user) {
    where(id: SharedSubscription.where(group_id: user.memberships.pluck(:group_id)).pluck(:subscription_id)).or(where(user: user))
  }


protected

  def smart_add_url_protocol
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      self.url = "http://#{url}"
    end
  end

end
