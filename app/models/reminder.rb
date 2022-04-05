class Reminder < ActiveRecord::Base
    belongs_to :subscription
    validates :end_date, presence: true
    validates :recurring, presence: true
    validates :reminder_type, presence: true

    scope :belonging_to_user, -> (user) {
        where(subscription_id: user.subscriptions.includes(:subscription_id))
    }

end