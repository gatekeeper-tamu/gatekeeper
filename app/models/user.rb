class User < ApplicationRecord
	class << self
		attr_accessor :email
		attr_accessor :username
		attr_accessor :password
		attr_accessor :first_name
		attr_accessor :last_name
		attr_accessor :image_url
	end

	devise :omniauthable, omniauth_providers: %i[google_oauth2]
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			puts auth
			user.email = auth.info.email
			user.username = user.email.split("@").first
			user.password = Devise.friendly_token[0, 20]
			user.first_name = auth.info.first_name   # assuming the user model has a name
			user.last_name = auth.info.last_name
			user.image_url = auth.info.image # assuming the user model has an image
			# If you are using confirmable and the provider(s) you use validate emails,
			# uncomment the line below to skip the confirmation emails.
			# user.skip_confirmation!
		end
	end
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable,
			:timeoutable, :omniauthable
	validates :username, presence: true
	validates_uniqueness_of :username

	has_many :subscriptions, dependent: :destroy
	has_many :owned_groups, class_name: 'Group', inverse_of: 'owner', dependent: :destroy
	has_many :memberships, dependent: :destroy
	has_many :groups, through: :memberships

	accepts_nested_attributes_for :subscriptions
	accepts_nested_attributes_for :owned_groups

  def is_viewer?(group)
		access = group_access_level(group)
		return (Membership.permissions[access] >= Membership.permissions[:viewer])
	end

	def is_collaborator?(group)
		access = group_access_level(group)
		return (Membership.permissions[access] >= Membership.permissions[:collaborator])
	end

	def is_admin?(group)
		access = group_access_level(group)
		return (Membership.permissions[access] == Membership.permissions[:admin])
	end

	def is_owner?(group)
		return (group.owner == self)
	end

	def group_access_level(group)
		if (is_owner?(group))
			# puts "User is owner"
			return Membership.permissions.key(2)
		end
		# puts "User is not owner"
		return group.user_access_level(self)
	end

	def can_view?(subscription)
		access = subscription_access_level(subscription)
		# puts "#{access} -> #{SharedSubscription.permissions[access]} = #{SharedSubscription.permissions[:viewer]}"
		return (SharedSubscription.permissions[access] >= SharedSubscription.permissions[:viewer])
	end

	def can_edit?(subscription)
		if (subscription.user == self)
			return true
		end
		access = subscription_access_level(subscription)
		# puts "#{access} -> #{SharedSubscription.permissions[access]} = #{SharedSubscription.permissions[:editor]}"
		return (SharedSubscription.permissions[access] == SharedSubscription.permissions[:editor])
	end

	def subscription_access_level(subscription)
		if (subscription.user == self)
			return SharedSubscription.permissions.key(2)
		end
		can_view = false
		can_edit = false
		for share_record in SharedSubscription.where(subscription_id: subscription.id, group_id: Group.accessible_by_user(self).pluck(:id))
			begin
				if (SharedSubscription.permissions[share_record.permission] == SharedSubscription.permissions[:viewer])
					can_view = true
				end
				if (SharedSubscription.permissions[share_record.permission] == SharedSubscription.permissions[:editor] and is_admin?(Group.find(share_record.group_id)))
					can_edit = true
					break
				end
				rescue ActiveRecord::RecordNotFound
			end
		end
		if (can_edit)
			SharedSubscription.permissions.key(2)
		elsif (can_view)
			SharedSubscription.permissions.key(1)
		else
			SharedSubscription.permissions.key(0)
		end
	end


	# definitions for statistics page
	def total_cost
    sum = 0
    for sub in subscriptions
      sum += sub.cost_per_month
    end
    return (sum).round(2)
	end

	def total_cost_overall
    sum = 0
    for sub in subscriptions
			sub_date = sub.created_at.to_datetime
			delta = ((Time.now - sub_date) / 60 / 60 / 24).round
			num_mo = (delta / 30 + 1)
      sum +=  sub.cost_per_month * num_mo
    end
		return (sum).round(2)
	end

	def total_groups
		sum = owned_groups.count + groups.count
    return sum
	end

	def all_groups
		return owned_groups + groups
	end

	def group_cost(group)
		sum = 0
    for sub in group.subscriptions
      sum += sub.cost_per_month
    end
    return (sum).round(2)
	end

end

