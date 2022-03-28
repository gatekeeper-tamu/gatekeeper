class Reminder < ActiveRecord::Base
    belongs_to :subscription

    scope :belonging_to_user, -> (user) {
        where(subscription_id: user.subscriptions.includes(:subscription_id))
    }

end